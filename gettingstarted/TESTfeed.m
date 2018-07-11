COM_CloseNXT('all')

F1addr = '00165308EE03';

F1 = COM_OpenNXTEx('USB', F1addr);

disp('FEED')

OpenLight(SENSOR_3,'ACTIVE',F1)
OpenSwitch(SENSOR_1,F1)

input('Press ENTER to start')

currentValueF = GetLight(SENSOR_3,F1);

for i = 1:1:2
    feedPallet(F1,SENSOR_1,MOTOR_A);
    movePalletToLightSensor(MOTOR_B,30,F1,SENSOR_3,currentValueF,20);
    pause(6)
end



