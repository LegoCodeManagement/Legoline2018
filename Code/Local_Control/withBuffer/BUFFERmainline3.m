COM_CloseNXT('all')
M3addr = '001653118B91';
M3 = COM_OpenNXTEx('USB', M3addr);

OpenLight(SENSOR_1, 'ACTIVE', nxtM3);
OpenLight(SENSOR_2, 'ACTIVE', nxtM3);

disp('MAINLINE 3')

mainline = NXTMotor(MOTOR_A,'Power',-40,'SpeedRegulation',false);

input('Press ENTER to start')
mainline.SendToNXT(M3);
input('Press ENTER to stop')
mainline.Stop('off',M3);


keepMainlineRunning.Stop('off', nxtM3);
CloseSensor(SENSOR_1, nxtM3);
CloseSensor(SENSOR_2, nxtM3);
COM_CloseNXT(nxtM3);

