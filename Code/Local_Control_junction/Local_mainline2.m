addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(6) = 49;
j3 = memmapfile('junction3.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_M',out{1})));
M2addr = char(out{2}(strcmp('Main2',out{1})));
M2delay = str2double(out{2}(strcmp('M2delay',out{1})));	
%open connection and activate sensors
nxtM2 = COM_OpenNXTEx('USB', M2addr);
OpenLight(SENSOR_1, 'ACTIVE', nxtM2);
OpenLight(SENSOR_2, 'ACTIVE', nxtM2);


mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);
fstatus.Data(6) = 50;
disp('MAINLINE 2');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.5);
end

ambientLight2 = GetLight(SENSOR_1, nxtM2);
mainline.SendToNXT(nxtM2);
%one timer for each pallet.
clearPalletM = [timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', M2delay);];


k=0;
%If pallet detected at start of mainline, wait for pallet to be detected at end.
%If not detected before timeout, display error.
while (fstatus.Data(1) == 49)
	while abs(GetLight(SENSOR_1, nxtM2) - ambientLight2) < 10
		pause(0.05);
	end
	j3.Data(1) = j3.Data(1) + 1;
	
	if fstatus.Data(1) ~= 49
        break
		disp('break');
    end
	
	if waitForPalletExit(nxtM2, SENSOR_1, ambientLight2, 10) == false
		disp('Error');
	end

	waitForPalletExit(nxtM2, SENSOR_1, ambientLight2, 10);
    
    if fstatus.Data(1) ~= 49
        break
		disp('break');
    end
	
	k = k+1;
	start(clearPalletM(k)); %start timer, which executes j2 = j2 - 1 after M1delay seconds.
	disp('Main2 clear');
	pause(0.1); %prevents updating to quickly
end

mainline.Stop('off', nxtM2);
disp('Main 2 STOPPED');
clear j3;
delete(timerfind);%Remove all timers from memory
CloseSensor(SENSOR_1, nxtM2);
CloseSensor(SENSOR_2, nxtM2);
COM_CloseNXT(nxtM2);
quit;