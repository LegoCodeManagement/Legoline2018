COM_CloseNXT('all')
M1addr = '0016530EE594';
M1 = COM_OpenNXTEx('USB', M1addr);

OpenLight(SENSOR_1, 'ACTIVE', nxtM1);
OpenLight(SENSOR_2, 'ACTIVE', nxtM1);

j2 = memmapfile('junction2.txt', 'Writable', true);

disp('MAINLINE 1')

mainline = NXTMotor(MOTOR_A,'Power',-40,'SpeedRegulation',false);

input('Press ENTER to start')


ambientLight1 = GetLight(SENSOR_1, nxtM1);
mainline.SendToNXT(M1);

clearPalletM = [timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8);];


k=0;
%while fileInit.Data(1) ~= 53
while k<5 % loop for 4 pallets
	while abs(GetLight(SENSOR_1, nxtM1) - ambientLight1) < 11
		%{
		if fileInit.Data(1) == 53
			clear j2;
			clear fileInit;
			delete(timerfind);
			keepMainlineRunning.Stop('off', nxtM1);
			CloseSensor(SENSOR_1, nxtM1);
			CloseSensor(SENSOR_2, nxtM1);
			COM_CloseNXT(nxtM1);
			quit;
		end
		%}
		pause(0.05);
	end
	j2.Data(1) = j2.Data(1) + 1;
	if waitForPalletExit(nxtM1, SENSOR_1, ambientLight1, 6) == false
		disp('Error');
	end

	waitForPalletExit(nxtM1, SENSOR_1, ambientLight1, 4);
	start(clearPalletM(k));
	k = k+1;
	disp('Main1 clear');
end
%end

clear j2;
delete(timerfind);%Remove all timers from memory
keepMainlineRunning.Stop('off', nxtM1);
CloseSensor(SENSOR_1, nxtM1);
CloseSensor(SENSOR_2, nxtM1);
COM_CloseNXT(nxtM1);





