addpath RWTHMindstormsNXT;

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(4) = 49;

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
power = str2double(out{2}(strcmp('SPEED_T',out{1})));
T1addr = char(out{2}(strcmp('Transfer1',out{1})));
T1angle = str2double(out{2}(strcmp('T1angle',out{1})));
T1delay = 2.5;

nxtT1 = COM_OpenNXTEx('USB', T1addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT1);
OpenSwitch(SENSOR_2, nxtT1);
OpenLight(SENSOR_1, 'ACTIVE', nxtT1);


j1 = memmapfile('junction1.txt', 'Writable', true);
j2 = memmapfile('junction2.txt', 'Writable', true);
b1 = memmapfile('buffer1.txt', 'Writable', true, 'Format', 'int8');

TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
fstatus.Data(4) = 50;
disp('TRANSFER 1');
disp('waiting for ready signal');
while fstatus.Data(1) == 48
    pause(0.1);
end

currentLight1 = GetLight(SENSOR_1, nxtT1);
currentLight3 = GetLight(SENSOR_3, nxtT1);

clearPalletT1 = [timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', T1delay);];

k=0;
while (k<11) && (fstatus.Data(1) == 49)
    	
	if (abs(GetLight(SENSOR_1, nxtT1) - currentLight1) > 100)
    
		b1.Data(2) = b1.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT1, SENSOR_3, currentLight3, 10, 20);
		
		while j1.Data(1) > 0
			pause(0.5);
			disp('mainline is busy') %this clogs up console, need another method
		end
		
		if fstatus.Data(1) ~= 49
            break
            disp('break');
        end
		k=k+1;
        j2.Data(1) = j2.Data(1) + 1;
		TransferArmRun(MOTOR_B, nxtT1, 105);
		start(clearPalletT1(k));
        b1.Data(2) = b1.Data(2) - 1;
		pause(0.8);
		TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
		
        disp(['transfer buffer = ', num2str(b1.Data(2))]);
        disp(['feed buffer = ', num2str(b1.Data(1))]);
        disp(['junction 1 = ', num2str(j1.Data(1))]);
        
    end
	pause(0.2);
end

disp('Transfer 1 STOPPED');
delete(timerfind);
clearvars j1 j2 b1;
CloseSensor(SENSOR_1, nxtT1);
CloseSensor(SENSOR_2, nxtT1);
CloseSensor(SENSOR_3, nxtT1);
COM_CloseNXT(nxtT1);