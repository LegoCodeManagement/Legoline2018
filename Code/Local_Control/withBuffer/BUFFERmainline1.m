COM_CloseNXT('all')

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

power = str2double(out{2}(strcmp('SPEED_M',out{1})));
M1addr = char(out{2}(strcmp('Main1',out{1})));

nxtM1 = COM_OpenNXTEx('USB', M1addr);

OpenLight(SENSOR_1, 'ACTIVE', nxtM1);
OpenLight(SENSOR_2, 'ACTIVE', nxtM1);

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
j2 = memmapfile('junction2.txt', 'Writable', true);



mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);

disp('MAINLINE 1')
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
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.8)];


k=0;
while (k<6) && (fstatus.Data(1) == 49)
	while abs(GetLight(SENSOR_1, nxtM1) - ambientLight1) < 11
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

mainline.Stop('off', nxtM1);
disp('Main 1 STOPPED');
clear j2;
delete(timerfind);%Remove all timers from memory
CloseSensor(SENSOR_1, nxtM1);
CloseSensor(SENSOR_2, nxtM1);
COM_CloseNXT(nxtM1);





