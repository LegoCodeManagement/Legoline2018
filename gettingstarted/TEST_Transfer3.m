COM_CloseNXT('all');
disp('Running transfer 3');
nxtT3Addr = '0016530A6F56';
nxtT3 = COM_OpenNXTEx('USB', nxtT3Addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT3);
OpenSwitch(SENSOR_2, nxtT3);
OpenLight(SENSOR_1, 'ACTIVE', nxtT3);
filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
m.Data(1) = 1;
while m.Data(1) == 1
    pause(0.25);
end
clear m;
currentLight1 = GetLight(SENSOR_1, nxtT3);
currentLight3 = GetLight(SENSOR_3, nxtT3);
resetTransferArm(MOTOR_B, SENSOR_2, nxtT3, 10);
%pause(1);
for i=1:1:3
    while (abs(GetLight(SENSOR_1, nxtT3) - currentLight1) < 11)
    end
    movePalletToLightSensor(MOTOR_A, -60, nxtT3, SENSOR_3, currentLight3);
    pause(0.2);
    runTransferArm(MOTOR_B, nxtT3, 103);
    pause(1);
    resetTransferArm(MOTOR_B, SENSOR_2, nxtT3, 10);
end
CloseSensor(SENSOR_1, nxtT3);
CloseSensor(SENSOR_2, nxtT3);
CloseSensor(SENSOR_3, nxtT3);
COM_CloseNXT(nxtT3);
quit