COM_CloseNXT('all')
M1addr = '0016530EE594';
M1 = COM_OpenNXTEx('USB', M1addr);

disp('MAINLINE')

mainline = NXTMotor(MOTOR_A,'Power',-40,'SpeedRegulation',false);

input('Press ENTER to start')
mainline.SendToNXT(M1);
input('Press ENTER to stop')
mainline.Stop('off',M1);



