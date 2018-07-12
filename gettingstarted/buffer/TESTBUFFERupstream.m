COM_CloseNXT('all')
Uaddr = '0016530EE120';
U = COM_OpenNXTEx('USB', Uaddr);

disp('UPSTREAM')

j1 = memmapfile('junction1.txt','Writable',true);

j1.Data(1)

OpenLight(SENSOR_2,'ACTIVE',U)
OpenSwitch(SENSOR_1,U)

input('Press ENTER to start')

currentValueU = GetLight(SENSOR_2,U);

palletHasLeft = [timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3)];

for i = 1:1:2
    j1.Data(1) = j1.Data(1) + 1;
    feedPallet(U,SENSOR_1,MOTOR_A);
    movePalletToLightSensor(MOTOR_B,30,U,SENSOR_2,currentValueU,20);

    start(palletHasLeft(i));
    pause(7)
end

input('press ENTER to stop')
delete(timerfind);

clear j1;
CloseSensor(SENSOR_1, nxtT1);
CloseSensor(SENSOR_2, nxtT1);
CloseSensor(SENSOR_3, nxtT1);
COM_CloseNXT(nxtT1);
