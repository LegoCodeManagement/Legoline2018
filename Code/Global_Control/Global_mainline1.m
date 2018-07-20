addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(3) = 49;
j2 = memmapfile('junction2.txt', 'Writable', true);
wait = memmapfile('wait.txt', 'Writable', true);

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_M',out{1})));
M1addr = char(out{2}(strcmp('Main1',out{1})));
M1delay = str2double(out{2}(strcmp('M1delay',out{1})));	
%open connection and activate sensors
nxtM1 = COM_OpenNXTEx('USB', M1addr);
OpenLight(SENSOR_1, 'ACTIVE', nxtM1);
OpenLight(SENSOR_2, 'ACTIVE', nxtM1);


mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);
fstatus.Data(3) = 50;
wait.Data(1) = 0;
disp('MAINLINE 1');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.1);
end

ambientLight1 = GetLight(SENSOR_1, nxtM1);
mainline.SendToNXT(nxtM1);
%one timer for each pallet.
clearPalletM = [timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', M1delay);];


k=0;
%If pallet detected at start of mainline, wait for pallet to be detected at end.
%If not detected before timeout, display error.
while (k<23) && (fstatus.Data(1) == 49)

	if abs(GetLight(SENSOR_1, nxtM1) - ambientLight1) < 40 
		k = k+1; 
		start(clearPalletM(k)); %start timer, which executes j2 = j2 - 1 after M1delay seconds.
	end
	
	j2.Data(1) = j2.Data(1) + 1;
	
	if wait.Data(1) == 1
		mainline.Stop('off', nxtM1);
		while wait.Data(1) == 1
			pause(0.2);
		end
		mainline.SendToNXT(nxtM1);
	end
	%need to add: wait for pallet exit
	pause(0.1); %prevents updating to quickly
end

mainline.Stop('off', nxtM1);
disp('Main 1 STOPPED');
clear j2;
delete(timerfind); %Remove all timers from memory
CloseSensor(SENSOR_1, nxtM1);
CloseSensor(SENSOR_2, nxtM1);
COM_CloseNXT(nxtM1);