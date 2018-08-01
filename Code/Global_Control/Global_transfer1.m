addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(4) = 49;

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_T',out{1})));
T1addr = char(out{2}(strcmp('Transfer1',out{1})));
T1angle = str2double(out{2}(strcmp('T1angle',out{1})));
T1delay = str2double(out{2}(strcmp('T1delay',out{1})));	
%open connection and activate sensors
nxtT1 = COM_OpenNXTEx('USB', T1addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT1);
OpenSwitch(SENSOR_2, nxtT1);
OpenLight(SENSOR_1, 'ACTIVE', nxtT1);

%allow feed to read and edit junction/buffer files
j1 = memmapfile('junction1.txt', 'Writable', true);
j2 = memmapfile('junction2.txt', 'Writable', true);
b1 = memmapfile('buffer1.txt', 'Writable', true, 'Format', 'int8');
m1 = memmapfile('m1.txt', 'Writable', true, 'Format', 'int8');
u1 = memmapfile('u1.txt', 'Writable', true, 'Format', 'int8');
wait = memmapfile('wait.txt', 'Writable', true);
global wait
priority = memmapfile('priority.txt', 'Writable', true);

TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle); %initialise
fstatus.Data(4) = 50;
disp('TRANSFER 1');
disp('Priority:')
disp(priority.Data);
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.1);
end
%detect ambient light in room
currentLight1 = GetLight(SENSOR_1, nxtT1);
currentLight3 = GetLight(SENSOR_3, nxtT1);
%one timer for each pallet.

k=0;
%run for 11 pallets or until told to stop
transferpallet1 = 49;
upstreampallet = 48;

while (k<12) && (fstatus.Data(1) == 49)

	if (abs(GetLight(SENSOR_1, nxtT1) - currentLight1) > 100) %triggers if pallet is detected
		b1.Data(2) = b1.Data(2) + 1;
		movePalletToLightSensorT(MOTOR_A, -power, nxtT1, SENSOR_3, currentLight3, 10, 20);
		
		if m1.Data(1) > 48
			while m1.Data(1) > 48
				pause(0.25);
				disp('mainline is busy')
			end
			
			k=k+1;
			TransferArmRun(MOTOR_B, nxtT1, 105);
			m1.Data(1) = m1.Data(1) + 1;
			b1.Data(2) = b1.Data(2) - 1; %remove one pallet from transfer line section of buffer
			pause(0.8);
			TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
			
			
		else
			if u1.Data(1) > 48 
		
				if checkpriority(transferpallet1,upstreampallet)
				
					k=k+1;
					wait.Data(1) = 49;						%tell upstream to stop
					TransferArmRun(MOTOR_B, nxtT1, 105);
					m1.Data(1) = m1.Data(1) + 1;
					b1.Data(2) = b1.Data(2) - 1; 			%remove one pallet from transfer line section of buffer
					pause(0.8);
					TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
					wait.Data(1) = 48; 						%tell upstream to resume
			
				else
					while u1.Data(1) > 48
						pause(0.5);
						disp('upstream is busy')
					end
					pause(1);
					while m1.Data(1) > 48
						pause(0.5);
						disp('mainline is busy')
					end
					
					k=k+1;
					TransferArmRun(MOTOR_B, nxtT1, 105);
					m1.Data(1) = m1.Data(1) + 1;
					b1.Data(2) = b1.Data(2) - 1; %remove one pallet from transfer line section of buffer
					pause(0.8);
					TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
				
				end
			end
        end
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