COM_CloseNXT('all');
disp('Running upstream');
nxtUAddr = '0016530EE120';
nxtU = COM_OpenNXTEx('USB', nxtUAddr);
OpenSwitch(SENSOR_1, nxtU);
OpenLight(SENSOR_2, 'ACTIVE', nxtU);
m = memmapfile('Junction1.txt', 'Writable', true);
input('Press ENTER to start');
currentLight2 = GetLight(SENSOR_2, nxtU);
for i=1:1:2
    m.Data(1) = 1; %1 means the mainline is busy
    feedPallet(nxtU, SENSOR_1, MOTOR_A);
    movePalletToLightSensor(MOTOR_B, 70, nxtU, SENSOR_2, currentLight2, 4);
    pause(1.8);
    m.Data(1) = 0;
    disp('Clear');
    pause(4);
end
clear m;
CloseSensor(SENSOR_2, nxtU);
CloseSensor(SENSOR_1, nxtU);
COM_CloseNXT(nxtU);
quit