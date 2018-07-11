nxtF3Addr = '0016530D6831';
disp('Running Feed3');
nxtF3 = COM_OpenNXTEx('USB', nxtF3Addr);
OpenSwitch(SENSOR_1, nxtF3);
OpenLight(SENSOR_3, 'ACTIVE', nxtF3);
filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
while m.Data(1) == 1
    pause(0.25);
end
clear m;
currentLight3 = GetLight(SENSOR_3, nxtF3);
for i=1:1:3
    feedPallet(nxtF3, SENSOR_1, MOTOR_A);
    movePalletToLightSensor(MOTOR_B, 70, nxtF3, SENSOR_3, currentLight3);
    pause(6);
end
CloseSensor(SENSOR_3, nxtF3);
CloseSensor(SENSOR_1, nxtF3);
COM_CloseNXT('all');
quit