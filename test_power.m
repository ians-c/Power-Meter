%Test accuracy if actual power meter is available

a = xlsread('Test3.xlsx');

actPower = a(:,1);
xl_dis = a(:,2);
xl_dis = xl_dis/1609.34;
Pact = max(actPower);

%Plot calculated power
figure(3)

subplot(121)
plot(total_dis, POWER)
title("Power vs. Distance (Calculated)")
xlabel('Distance (miles)')
ylabel('Power (W)')
Pmax = max(POWER);
axis([0 total_dis(end) 0 Pact+50])
pbaspect([3 2 1])

%Plot actual power (optional)
subplot(122)
plot(xl_dis, actPower)
title("Power vs. Distance (Actual)")
xlabel('Distance (miles)')
ylabel('Power (W)')
axis([0 total_dis(end) 0 Pact+50])
pbaspect([3 2 1])


