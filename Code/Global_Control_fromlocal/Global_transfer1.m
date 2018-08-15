addpath RWTHMindstormsNXT;

%establish memory map to status.txt. 
fstatus	 = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(4) = 49;
b1		 = memmapfile('buffer1.txt', 'Writable', true, 'Format', 'int8');
m1		 = memmapfile('count_m1.txt', 'Writable', true, 'Format', 'int8');
u1		 = memmapfile('count_u1.txt', 'Writable', true, 'Format', 'int8');
wait	 = memmapfile('wait.txt', 'Writable', true);
priority = memmapfile('priority.txt', 'Writable', true);

global wait
global fstatus

%open config file and save variable names and values column 1 and 2 respectively set variables accordingly
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
power 		= str2double(out{2}(strcmp('SPEED_T',out{1})));
T1addr		= char(out{2}(strcmp('Transfer1',out{1})));
T1angle 	= str2double(out{2}(strcmp('T1angle',out{1})));
T1delay 	= str2double(out{2}(strcmp('T1delay',out{1})));	
T1armwait	= str2double(out{2}(strcmp('T1armwait',out{1})));
Tthreshold	= str2double(out{2}(strcmp('Tthreshold',out{1})));	

%open connection, activate sensors and reset arm
nxtT1 = COM_OpenNXTEx('USB', T1addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT1);
OpenSwitch(SENSOR_2, nxtT1);
OpenLight(SENSOR_1, 'ACTIVE', nxtT1);
TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);

%signal that this module is ready
fstatus.Data(4) = 50;
disp('TRANSFER 1');
disp('waiting for ready signal');

%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.1);
end

%detect ambient light in room
currentLight1 = GetLight(SENSOR_1, nxtT1);
currentLight3 = GetLight(SENSOR_3, nxtT1);

transferpallet1 = 50;
upstreampallet = 49;

%run until told to stop
while (fstatus.Data(1) == 49)
	if (abs(GetLight(SENSOR_1, nxtT1) - currentLight1) > 100) %triggers if pallet is detected
		b1.Data(2) = b1.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT1, SENSOR_3, currentLight3, 10, Tthreshold);
		
		while (m1.Data(1) > 48) && (checkStop)
			pause(0.2);
			disp('mainline is busy')
		end
		
		while b1.Data(2) > 48
		
			if u1.Data(1) > 48
	
				if checkpriority(transferpallet1,u1.Data(1)) %
			
					wait.Data(2) = 49;						%tell upstream to stop
					TransferArmRun(MOTOR_B, nxtT1, 105);
				
					addpallet(transferpallet1,'count_m1.txt')
				
					b1.Data(2) = b1.Data(2) - 1; 			%remove one pallet from transfer line section of buffer
					pause(T1armwait);
					TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
					wait.Data(2) = 48; 						%tell upstream to resume
		
				else
			
					while (m1.Data(1)>48) && (checkStop) %if there is delay between m1=m1+1 and u1=u1-1 then may clash.
						pause(0.1);
						disp('main is busy')
					end
				
				end
		
			else
				TransferArmRun(MOTOR_B, nxtT1, 105);
			
				addpallet(transferpallet1,'count_m1.txt')
			
				b1.Data(2) = b1.Data(2) - 1; 			%remove one pallet from transfer line section of buffer
				pause(T1armwait);
				TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);	
			
			end
		end
    end
	pause(0.1);
end

disp('Transfer 1 STOPPED');
delete(timerfind);
clearvars m1 b1 u1;
CloseSensor(SENSOR_1, nxtT1);
CloseSensor(SENSOR_2, nxtT1);
CloseSensor(SENSOR_3, nxtT1);
COM_CloseNXT(nxtT1);
quit;