COM_CloseNXT('all');
disp('Running Feed2');
nxtF2Addr = '001653118A50';
nxtF2 = COM_OpenNXTEx('USB', nxtF2Addr);
OpenSwitch(SENSOR_1, nxtF2);
OpenLight(SENSOR_3, 'ACTIVE', nxtF2);
filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
while m.Data(1) == 1
    pause(0.25);
end
clear m;
currentLight3 = GetLight(SENSOR_3, nxtF2);
for i=1:1:3
    feedPallet(nxtF2, SENSOR_1, MOTOR_A);
    movePalletToLightSensor(MOTOR_B, 70, nxtF2, SENSOR_3, currentLight3);
    pause(6);
end
CloseSensor(SENSOR_3, nxtF2);
CloseSensor(SENSOR_1, nxtF2);
COM_CloseNXT('all');
quit