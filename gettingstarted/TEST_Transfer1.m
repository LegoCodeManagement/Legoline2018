COM_CloseNXT('all');
disp('Running transfer 1');
nxtT1Addr = '0016530AABDF';
nxtT1 = COM_OpenNXTEx('USB', nxtT1Addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT1);
OpenSwitch(SENSOR_2, nxtT1);
OpenLight(SENSOR_1, 'ACTIVE', nxtT1);
%{
filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
while m.Data(1) == 1
    pause(0.25);
end
clear m;
%}
resetTransferArm(MOTOR_B, SENSOR_2, nxtT1, 16);
m = memmapfile('Junction1.txt', 'Writable', true);
input('Press ENTER to start');
currentLight1 = GetLight(SENSOR_1, nxtT1);
currentLight3 = GetLight(SENSOR_3, nxtT1);
for i=1:1:3
    while (abs(GetLight(SENSOR_1, nxtT1) - currentLight1) < 11)
    end
    movePalletToLightSensor(MOTOR_A, -60, nxtT1, SENSOR_3, currentLight3, 4);
    while (m.Data(1) == 1)
        pause(0.25);
    end
    runTransferArm(MOTOR_B, nxtT1, 105);
    pause(1);
    resetTransferArm(MOTOR_B, SENSOR_2, nxtT1, 16);
end
clear m;
CloseSensor(SENSOR_1, nxtT1);
CloseSensor(SENSOR_2, nxtT1);
CloseSensor(SENSOR_3, nxtT1);
COM_CloseNXT(nxtT1);
quit;