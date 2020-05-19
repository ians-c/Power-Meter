clc;
clf;

%Variables
file = input('Enter file name:');
weight_rider = input('How much do you weigh(lbs)?');
weight_bike = input('How much does your bike weigh(lbs)?');
mass = (weight_rider + weight_bike)*.4535;
crolling = 0.004;
cdrag = 0.4;
A = 0.7;
drive_train_eff = .95;

g = gpxread('file');

%Data
lat_mat = g.Latitude;
lon_mat = g.Longitude;
time_mat = g.Time;
ele = g.Elevation;

%Extract Times and Day
timeStr = strrep(g.Time, 'T', ' ');
timeStr = strrep(timeStr, 'Z', '');

time_num = datenum(timeStr);
time_num = time_num.';

start_time_UCT = time_num(1);
start_time_UCT = datestr(start_time_UCT, 'HH'); 
start_time_UCT = str2double(start_time_UCT);

day = fix(time_num(1));
day = datestr(day, 'yyyy-mm-dd');

%Find Displacement
dt = diff(time_num);
dt = dt*60*60*24;
time_num(1) = [];
ellipsoid = wgs84Ellipsoid;
dis = [];
for i=1:length(g)-1
    dist = distance(lat_mat(i),lon_mat(i), lat_mat(i+1), lon_mat(i+1), ellipsoid);
    dis = [dis dist];
end

%Find Direction
direction = [];

for i = 1:length(lat_mat)-1
    dir = mod(atan2(sin(lon_mat(i+1)-lon_mat(i))*cos(lat_mat(i+1)),...
    cos(lat_mat(i))*sin(lat_mat(i+1))-sin(lat_mat(i))*cos(lat_mat(i+1))*cos(lon_mat(i+1)-lon_mat(i))), 2*pi);   

    direction = [direction; dir];
end
 
direction = rad2deg(direction);

lat_diff = diff(lat_mat);
lon_diff = diff(lon_mat);
dele = diff(ele);
total_dis = cumsum(dis);
total_dis = total_dis./1609.34;

%Find Velocity
vel = dis./dt;
vel = filloutliers(vel,'next');
vel = smoothdata(vel, 'sgolay',30);

%Find Acceleration
accel = diff(vel);

%Get weather
run_weather

% Power to overcome wind
angle_diff = direction - wind_direction;
ag = -cosd(angle_diff);
res = wind.*ag;
res = res.';
vel_rel = vel+res;
[T, ab, P, rho] = atmosisa(ele);
rho(1)=[];
P_wind = rho.*(vel_rel.^3)*.5*cdrag*A;
P_wind = filloutliers(P_wind,'center');
P_wind = smoothdata(P_wind);

%Power to overcome gravity
angle = atan(dele./dis);
angle = smoothdata(angle);
Fgy = mass*9.81*sin(angle);
P_grav = Fgy.*vel;


%Power to overcome rolling resistance
Fgx = mass*9.81*cos(angle);
P_roll = crolling*vel.*Fgx;


%Power to accelerate
a_n = length(accel);
accel = [accel accel(a_n)];
accel = filloutliers(accel,'next');
P_accel = mass*vel.*accel;
P_accel = smoothdata(P_accel);


%Total Power
POWER = P_roll + P_accel + P_grav + P_wind;


POWER(POWER<0)=0;
POWER = filloutliers(POWER,'next');
POWER = smoothdata(POWER,'movmean', 3);
POWER = POWER/drive_train_eff;
avg = nanmean(POWER);
fprintf("Average Power: %3.f Watts",avg)
avg_power = avg.* ones(length(POWER),1);

%Graphs
vel = 2.2369*vel;
vel_avg = nanmean(vel);
fprintf('\nAverage Speed: %.1f',vel_avg)

figure(1)
plot(total_dis,vel)
title('Velocity')
axis([0 total_dis(end) 0 max(vel)+5])
xlabel('Distance (miles)')
ylabel('Speed (mph)')

%Plot calculated power
figure(2)
plot(total_dis, POWER)
title("Power vs. Distance")
xlabel('Distance (miles)')
ylabel('Power (W)')
Pmax = max(POWER);
axis([0 total_dis(end) 0 Pmax+50])
pbaspect([3 2 1])

%Compare to actual values if available
test_power



