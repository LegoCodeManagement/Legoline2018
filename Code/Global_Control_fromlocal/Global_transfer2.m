addpath RWTHMindstormsNXT;

%establish memory map to files
fstatus  = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(7) = 49;
b2 		 = memmapfile('buffer2.txt', 'Writable', true, 'Format', 'int8');
m1		 = memmapfile('count_m1.txt', 'Writable', true);
m2		 = memmapfile('count_m2.txt', 'Writable', true);
wait 	 = memmapfile('wait.txt', 'Writable', true);
priority = memmapfile('priority.txt', 'Writable', true);

global wait
global fstatus

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
power 		= str2double(out{2}(strcmp('SPEED_T',out{1})));
T2addr		= char(out{2}(strcmp('Transfer2',out{1})));
T2angle 	= str2double(out{2}(strcmp('T2angle',out{1})));
T2delay 	= str2double(out{2}(strcmp('T2delay',out{1})));	
T2armwait	= str2double(out{2}(strcmp('T2armwait',out{1})));
Tthreshold  = str2double(out{2}(strcmp('Tthreshold',out{1})));

%open connection and activate sensors
nxtT2 = COM_OpenNXTEx('USB', T2addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT2);
OpenSwitch(SENSOR_2, nxtT2);
OpenLight(SENSOR_1, 'ACTIVE', nxtT2);
TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);

%signal that this module is ready
fstatus.Data(7) = 50;
disp('TRANSFER 2');
disp('waiting for ready signal');

%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.1);
end

%detect ambient light in room
currentLight1 = GetLight(SENSOR_1, nxtT2);
currentLight3 = GetLight(SENSOR_3, nxtT2);

transferpallet2 = 51;
upstreampallet = 49;

%run until told to stop
while (fstatus.Data(1) == 49)
    if (abs(GetLight(SENSOR_1, nxtT2) - currentLight1) > 100) %triggers if pallet is detected
		b2.Data(2) = b2.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT2, SENSOR_3, currentLight3, 10, Tthreshold);
		
		while (m2.Data(1) > 48) && (checkStop)
			pause(0.2);
			disp('mainline is busy')
		end
		
		while b2.Data(2) > 48
		
			if m1.Data(1) > 48
	
				if checkpriority(transferpallet2,m1.Data(1)) %
			
					wait.Data(2) = 49;						%tell upstream to stop
					TransferArmRun(MOTOR_B, nxtT2, 105);
				
					addpallet(transferpallet2,'count_m2.txt')
				
					b2.Data(2) = b2.Data(2) - 1; 			%remove one pallet from transfer line section of buffer
					pause(T2armwait);
					TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);
					wait.Data(2) = 48; 						%tell upstream to resume
		
				else
			
					while (m2.Data(1)>48) && (checkStop) %if there is delay between m1=m1+1 and u1=u1-1 then may clash.
						pause(0.1);
						disp('upstream is busy')
					end
				
				end
		
			else
				TransferArmRun(MOTOR_B, nxtT2, 105);
			
				addpallet(transferpallet2,'count_m2.txt')
			
				b2.Data(2) = b2.Data(2) - 1; 			%remove one pallet from transfer line section of buffer
				pause(T2armwait);
				TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);	
			
			end
		end
    end
	pause(0.1);
end

disp('Transfer 2 STOPPED')
delete(timerfind);
clearvars m1 m2 b2;
CloseSensor(SENSOR_1, nxtT2);
CloseSensor(SENSOR_2, nxtT2);
CloseSensor(SENSOR_3, nxtT2);
COM_CloseNXT(nxtT2);
quit;