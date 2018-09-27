addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(7) = 49;

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_T',out{1})));
T2addr = char(out{2}(strcmp('Transfer2',out{1})));
T2angle = str2double(out{2}(strcmp('T2angle',out{1})));
T2delay = str2double(out{2}(strcmp('T2delay',out{1})));	
%open connection and activate sensors
nxtT2 = COM_OpenNXTEx('USB', T2addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT2);
OpenSwitch(SENSOR_2, nxtT2);
OpenLight(SENSOR_1, 'ACTIVE', nxtT2);

%allow feed to read and edit junction/buffer files
m1 = memmapfile('m1.txt', 'Writable', true);
m2 = memmapfile('m2.txt', 'Writable', true);
b2 = memmapfile('buffer2.txt', 'Writable', true, 'Format', 'int8');
wait = memmapfile('wait.txt', 'Writable', true);
global wait
priority = memmapfile('priority.txt', 'Writable', true);

TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);
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
%one timer for each pallet.
clearPalletT2 = [timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);
                timer('TimerFcn', 'j3.Data(1) = j3.Data(1) - 1;', 'StartDelay', 3.3);];

k=0;
%run for 11 pallets or until told to stop
transferpallet2 = 50;
upstreampallet = 48;


while (k<12) && (fstatus.Data(1) == 49)
    	if (abs(GetLight(SENSOR_1, nxtT2) - currentLight1) > 100) %triggers if pallet is detected
		b2.Data(2) = b2.Data(2) + 1;
		movePalletToLightSensorT(MOTOR_A, -power, nxtT2, SENSOR_3, currentLight3, 10, 20);
		
		if m2.Data(1) > 48
			while m2.Data(1) > 48
				pause(0.25);
				disp('mainline is busy')
			end
			
			k=k+1;
			TransferArmRun(MOTOR_B, nxtT2, 105);
			m2.Data(1) = m2.Data(1) + 1;
			b2.Data(2) = b2.Data(2) - 1; %remove one pallet from transfer line section of buffer
			pause(0.8);
			TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);
			
			
		else
			if m1.Data(1) > 48 
		
				if checkpriority(transferpallet2,upstreampallet)
				
					k=k+1;
					wait.Data(2) = 49;						%tell upstream to stop
					TransferArmRun(MOTOR_B, nxtT2, 105);
					m2.Data(1) = m2.Data(1) + 1;
					b2.Data(2) = b2.Data(2) - 1; 			%remove one pallet from transfer line section of buffer
					pause(0.8);
					TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);
					wait.Data(2) = 48; 						%tell upstream to resume
			
				else
					while m1.Data(1) > 48
						pause(0.5);
						disp('upstream is busy')
					end

					k=k+1;
					TransferArmRun(MOTOR_B, nxtT2, 105);
					m2.Data(1) = m2.Data(1) + 1;
					b2.Data(2) = b2.Data(2) - 1; %remove one pallet from transfer line section of buffer
					pause(0.8);
					TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);
				
				end
			end
        end
    end
	pause(0.2);
end

disp('Transfer 2 STOPPED')
delete(timerfind);
clearvals j2 j3 b2;
CloseSensor(SENSOR_1, nxtT2);
CloseSensor(SENSOR_2, nxtT2);
CloseSensor(SENSOR_3, nxtT2);
COM_CloseNXT(nxtT2);