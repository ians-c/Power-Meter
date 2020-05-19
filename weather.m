clc;

%Find nearest station
key = '4jXzCJ1y';
api1 = 'https://api.meteostat.net/v1/stations/nearby?';
latfirst = num2str(lat_mat(1));
lonfirst = num2str(lon_mat(1));
loc = ['lat=' latfirst '&lon=' lonfirst];
api1 = [api1 loc '&limit=1&key=' key];
s = webread(api1);
station = s.data.id;

%Find wind/temp based on first location
timezone = 'America/New_York';
api2 = 'https://api.meteostat.net/v1/history/hourly?';
station = num2str(station);
api2 = [api2 'station=' station '&start=' day '&end=' day '&time_zone=' timezone '&time_format=Y-m-d%20H:i&key=' key];
t = webread(api2);
wind_mat = [t.data.windspeed];
wind_direction_mat = [t.data.winddirection];

start_time_loc = start_time_UCT - 4; %Calibrated for EST

wind = wind_mat(start_time_loc);
wind = wind*.27778;
wind_direction = wind_direction_mat(start_time_loc);



