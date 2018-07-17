addpath RWTHMindstormsNXT;

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(3) = 49;
j2 = memmapfile('junction2.txt', 'Writable', true);

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





mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);
fstatus.Data(5) = 50;
disp('MAINLINE 1');
disp('waiting for ready signal');
while fstatus.Data(1) == 49
    pause(0.1);
end

ambientLight1 = GetLight(SENSOR_1, nxtM1);
mainline.SendToNXT(nxtM1);

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
    
    if fstatus.Data(1) ~= 49
        break
		disp('break');
    end
    
	if waitForPalletExit(nxtM1, SENSOR_1, ambientLight1, 6) == false
		disp('Error');
	end

	waitForPalletExit(nxtM1, SENSOR_1, ambientLight1, 4);
    
    if fstatus.Data(1) ~= 49
        break
		disp('break');
    end
    
	k = k+1;
    start(clearPalletM(k));
	disp('Main1 clear');
end

mainline.Stop('off', nxtM1);
disp('Main 1 STOPPED');
clear j2;
delete(timerfind);%Remove all timers from memory
CloseSensor(SENSOR_1, nxtM1);
CloseSensor(SENSOR_2, nxtM1);
COM_CloseNXT(nxtM1);





