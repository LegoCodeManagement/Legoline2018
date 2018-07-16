addpath RWTHMindstormsNXT;

COM_CloseNXT('all')

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
power = str2double(out{2}(strcmp('SPEED_T',out{1})));
T2addr = char(out{2}(strcmp('Transfer2',out{1})));

nxtT2 = COM_OpenNXTEx('USB', T2addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT2);
OpenSwitch(SENSOR_2, nxtT2);
OpenLight(SENSOR_1, 'ACTIVE', nxtT2);

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
j2 = memmapfile('junction2.txt', 'Writable', true);
j3 = memmapfile('junction3.txt', 'Writable', true);
b2 = memmapfile('buffer2.txt', 'Writable', true, 'Format', 'int8');

TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, 16);
currentLight1 = GetLight(SENSOR_1, nxtT2);
currentLight3 = GetLight(SENSOR_3, nxtT2);

disp('TRANSFER 2')
input('press ENTER to start')

clearPalletT2 = [timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1', 'StartDelay', 3.3)];

k=0;
while (k<6) && (fstatus.Data(1) == 49)
    	
	if (abs(GetLight(SENSOR_1, nxtT2) - currentLight1) > 11)
    
		b1.Data(2) = b1.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT2, SENSOR_3, currentLight3, 4);
		
		while j2.Data(1) == 1
			pause(0.25)
			disp('mainline is busy') %this clogs up console, need another method
		end
		
		if fstatus.Data(1) ~= 49
            break
            disp('break');
        end
		
		TransferArmRun(MOTOR_B, nxtT2, 105);
		start(clearPalletT2(k))
		pause(0.6);
		TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, 16);
		
		b1.Data(2) = b1.Data(2) - 1;
		
		k=k+1;
		
        disp(['transfer buffer = ', num2str(b1.Data(2))]);
        disp(['feed buffer = ', num2str(b1.Data(1))]);
        disp(['junction 1 = ', num2str(j2.Data(1))]);
        
    end
	pause(0.2);
end

disp('Transfer 1 STOPPED')
delete(timerfind);
clearvals j2 j3 b2;
CloseSensor(SENSOR_1, nxtT2);
CloseSensor(SENSOR_2, nxtT2);
CloseSensor(SENSOR_3, nxtT2);
COM_CloseNXT(nxtT2);