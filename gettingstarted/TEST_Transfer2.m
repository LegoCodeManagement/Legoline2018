COM_CloseNXT('all');
disp('Running transfer 2');
nxtT2Addr = '0016530EE129';
nxtT2 = COM_OpenNXTEx('USB', nxtT2Addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT2);
OpenSwitch(SENSOR_2, nxtT2);
OpenLight(SENSOR_1, 'ACTIVE', nxtT2);
filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
while m.Data(1) == 1
    pause(0.25);
end
clear m;
currentLight1 = GetLight(SENSOR_1, nxtT2);
currentLight3 = GetLight(SENSOR_3, nxtT2);
resetTransferArm(MOTOR_B, SENSOR_2, nxtT2, 10);
%pause(1);
for i=1:1:3
    while (abs(GetLight(SENSOR_1, nxtT2) - currentLight1) < 11)
    end
    movePalletToLightSensor(MOTOR_A, -60, nxtT2, SENSOR_3, currentLight3);
    runTransferArm(MOTOR_B, nxtT2, 112);
    pause(1);
    resetTransferArm(MOTOR_B, SENSOR_2, nxtT2, 10);
end
CloseSensor(SENSOR_1, nxtT2);
CloseSensor(SENSOR_2, nxtT2);
CloseSensor(SENSOR_3, nxtT2);
COM_CloseNXT(nxtT2);
quit