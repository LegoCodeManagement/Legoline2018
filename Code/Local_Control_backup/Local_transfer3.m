addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(10) = 49;

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_T',out{1})));
T3addr = char(out{2}(strcmp('Transfer3',out{1})));
T3angle = str2double(out{2}(strcmp('T3angle',out{1})));

%open connection and activate sensors
nxtT3 = COM_OpenNXTEx('USB', T3addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT3);
OpenSwitch(SENSOR_2, nxtT3);
OpenLight(SENSOR_1, 'ACTIVE', nxtT3);


j3 = memmapfile('junction3.txt', 'Writable', true);
b3 = memmapfile('buffer3.txt', 'Writable', true, 'Format', 'int8');

TransferArmReset(MOTOR_B, SENSOR_2, nxtT3, T3angle);
fstatus.Data(10) = 50;
disp('TRANSFER 3');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.1);
end

currentLight1 = GetLight(SENSOR_1, nxtT3);
currentLight3 = GetLight(SENSOR_3, nxtT3);














k=0;
%run for 11 pallets or until told to stop
while (k<12) && (fstatus.Data(1) == 49) 
    %if we detect a pallet at start of transfer line, move it to transfer arm		
	if (abs(GetLight(SENSOR_1, nxtT3) - currentLight1) > 100)
    
		b3.Data(2) = b3.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT3, SENSOR_3, currentLight3, 4,20);
		
		while j3.Data(1) > 48
			pause(0.5);
			disp('mainline is busy') %this clogs up console, need another method
            if fstatus.Data(1) ~= 49
                break
                disp('break');
            end
		end
		
		if fstatus.Data(1) ~= 49
            break
            disp('break');
        end
        
        k=k+1;
        
		TransferArmRun(MOTOR_B, nxtT3, 105);
		b3.Data(2) = b3.Data(2) - 1;
		pause(0.6);
		TransferArmReset(MOTOR_B, SENSOR_2, nxtT3, T3angle);
		
        disp(['transfer buffer = ', num2str(b3.Data(2))]);
        disp(['feed buffer = ', num2str(b3.Data(1))]);
        disp(['junction 1 = ', num2str(j3.Data(1))]);
        
    end
	pause(0.2);
end

disp('Transfer 3 STOPPED');
delete(timerfind);
clearvars j3 b3;
CloseSensor(SENSOR_1, nxtT3);
CloseSensor(SENSOR_2, nxtT3);
CloseSensor(SENSOR_3, nxtT3);
COM_CloseNXT(nxtT3);
quit;