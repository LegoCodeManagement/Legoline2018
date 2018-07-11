COM_CloseNXT('all');
disp('Running Feed1');
nxtF1Addr = '00165308EE03';
nxtF1 = COM_OpenNXTEx('USB', nxtF1Addr);
OpenSwitch(SENSOR_1, nxtF1);
OpenLight(SENSOR_3, 'ACTIVE', nxtF1);
input('Press ENTER to start');
%{
filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
while m.Data(1) == 1
    pause(0.25);
end
clear m;
%}
currentLight3 = GetLight(SENSOR_3, nxtF1);
for i=1:1:3
    feedPallet(nxtF1, SENSOR_1, MOTOR_A);
    movePalletToLightSensor(MOTOR_B, 70, nxtF1, SENSOR_3, currentLight3, 3);
    pause(8);
end
input('Press ENTER to stop');
CloseSensor(SENSOR_3, nxtF1);
CloseSensor(SENSOR_1, nxtF1);
COM_CloseNXT('all');
quit;