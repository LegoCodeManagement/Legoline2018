COM_CloseNXT('all')

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
power = str2double(out{2}(strcmp('SPEED_T',out{1})));
T3addr = char(out{2}(strcmp('Transfer3',out{1})));

nxtT3 = COM_OpenNXTEx('USB', T3addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT3);
OpenSwitch(SENSOR_2, nxtT3);
OpenLight(SENSOR_1, 'ACTIVE', nxtT3);

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');

j3 = memmapfile('junction3.txt', 'Writable', true);
b3 = memmapfile('buffer3.txt', 'Writable', true, 'Format', 'int8');

TransferArmReset(MOTOR_B, SENSOR_2, nxtT3, 16);
currentLight1 = GetLight(SENSOR_1, nxtT3);
currentLight3 = GetLight(SENSOR_3, nxtT3);

disp('TRANSFER 3')
input('press ENTER to start')














k=0;
while (k<6) && (fstatus.Data(1) == 49) 
    	
	if (abs(GetLight(SENSOR_1, nxtT3) - currentLight1) > 11)
    
		b3.Data(2) = b3.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT3, SENSOR_3, currentLight3, 4);
		
		while j3.Data(1) == 1
			pause(0.25);
			disp('mainline is busy') %this clogs up console, need another method
		end
		
		if fstatus.Data(1) ~= 49
            break
            disp('break');
        end
		
		TransferArmRun(MOTOR_B, nxtT3, 105);
		start(clearPalletT3(k))
		pause(0.6);
		TransferArmReset(MOTOR_B, SENSOR_2, nxtT3, 16);
		
		b3.Data(2) = b3.Data(2) - 1;
		
		k=k+1;
		
        disp(['transfer buffer = ', num2str(b3.Data(2))]);
        disp(['feed buffer = ', num2str(b3.Data(1))]);
        disp(['junction 1 = ', num2str(j1.Data(1))]);
        
    end
	pause(0.2);
end

disp('Transfer 1 STOPPED')
delete(timerfind);
clearvals j3 b3;
CloseSensor(SENSOR_1, nxtT3);
CloseSensor(SENSOR_2, nxtT3);
CloseSensor(SENSOR_3, nxtT3);
COM_CloseNXT(nxtT3);