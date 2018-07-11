COM_CloseNXT('all')
T1addr = '0016530AABDF';
T1 = COM_OpenNXTEx('USB', T1addr);

disp('TRANSFER')

fileJunc1 = memmapfile('Junction1.txt','Writable',true);
fileJunc2 = memmapfile('Junction2.txt','Writable',true);


OpenLight(SENSOR_3,'ACTIVE',T1);
OpenLight(SENSOR_1,'ACTIVE',T1);
OpenSwitch(SENSOR_2,T1);

resetTransferArm(MOTOR_B,SENSOR_2,T1,19);

input('Press ENTER to start')

currentLightT1 = GetLight(SENSOR_1,T1);
currentLightT3 = GetLight(SENSOR_3,T1);

palletHasLeft = [timer('TimerFcn','fileJunc2.Data(1) = fileJunc2.Data(1) - 1','StartDelay',3.3); 
                 timer('TimerFcn','fileJunc2.Data(1) = fileJunc2.Data(1) - 1','StartDelay',3.3)];

for i = 1:1:2
    while abs(GetLight(SENSOR_1,T1)-currentLightT1)<11
        pause(0.1)
    end
    disp('current number of pallets before:')
    movePalletToLightSensor(MOTOR_A,-40,T1,SENSOR_3,currentLightT3,6);
    
    while fileJunc1.Data(1) > 48
        pause(1);
        disp('waiting for mainline to be cleared')
        fileJunc1.Data(1)
    end
    
    fileJunc2.Data(1) = fileJunc2.Data(1) + 1;
    runTransferArm(MOTOR_B,T1,105);
    
    start(palletHasLeft(i));
    pause(1);
    resetTransferArm(MOTOR_B,SENSOR_2,T1,19);
end

pause(3)
delete(timerfind);