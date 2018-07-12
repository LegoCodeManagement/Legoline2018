COM_CloseNXT('all')
M2addr = '001653118AC9';
M2 = COM_OpenNXTEx('USB', M2addr);

OpenLight(SENSOR_1, 'ACTIVE', nxtM2);
OpenLight(SENSOR_2, 'ACTIVE', nxtM2);

j3 = memmapfile('junction2.txt', 'Writable', true);

disp('MAINLINE 2')

mainline = NXTMotor(MOTOR_A,'Power',-40,'SpeedRegulation',false);

input('Press ENTER to start')
mainline.SendToNXT(M2);


clearPalletM = [timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.8);];


k=0;
%while fileInit.Data(1) ~= 53
while k<5 % loop for 4 pallets
	while abs(GetLight(SENSOR_1, nxtM2) - ambientLight1) < 11
		%{
		if fileInit.Data(1) == 53
			clear j3;
			clear fileInit;
			delete(timerfind);
			keepMainlineRunning.Stop('off', nxtM2);
			CloseSensor(SENSOR_1, nxtM2);
			CloseSensor(SENSOR_2, nxtM2);
			COM_CloseNXT(nxtM2);
			quit;
		end
		%}
		pause(0.05);
	end
	j3.Data(1) = j3.Data(1) + 1;
	if waitForPalletExit(nxtM2, SENSOR_1, ambientLight1, 6) == false
		disp('Error');
	end

	waitForPalletExit(nxtM2, SENSOR_1, ambientLight1, 4);
	start(clearPalletM(k));
	k = k+1;
	disp('Main1 clear');
end
%end

clear j3;
delete(timerfind);%Remove all timers from memory
keepMainlineRunning.Stop('off', nxtM2);
CloseSensor(SENSOR_1, nxtM2);
CloseSensor(SENSOR_2, nxtM2);
COM_CloseNXT(nxtM2);



