COM_CloseNXT('all')
Uaddr = '0016530EE120';
U = COM_OpenNXTEx('USB', Uaddr);

disp('UPSTREAM')

fileJunc1 = memmapfile('Junction1.txt','Writable',true);

fileJunc1.Data(1)

OpenLight(SENSOR_2,'ACTIVE',U)
OpenSwitch(SENSOR_1,U)

input('Press ENTER to start')

currentValueU = GetLight(SENSOR_2,U);

palletHasLeft = [timer('TimerFcn','fileJunc1.Data(1) = fileJunc1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','fileJunc1.Data(1) = fileJunc1.Data(1) - 1','StartDelay',3)];

for i = 1:1:2
    fileJunc1.Data(1) = fileJunc1.Data(1) + 1;
    feedPallet(U,SENSOR_1,MOTOR_A);
    movePalletToLightSensor(MOTOR_B,30,U,SENSOR_2,currentValueU,20);

    start(palletHasLeft(i));
    pause(7)
end

input('press ENTER to stop')
delete(timerfind);

