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
wait = memmapfile('wait.txt', 'Writable', true);
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
clearPalletT1 =[timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1;', 'StartDelay', T1delay);];

k=0;
%run for 11 pallets or until told to stop
transferpallet = 49;
upstreampallet = 50;

while (k<12) && (fstatus.Data(1) == 49)
	if (abs(GetLight(SENSOR_1, nxtT1) - currentLight1) > 100) %triggers if pallet is detected
		b1.Data(2) = b1.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT1, SENSOR_3, currentLight3, 10, 20,0);
		
		if j1.Data(1) > 0 %If mainline is busy
		
		 	%check priority, if pallet on transfer arm has priority then this next statement triggers
			if find((priority.Data == transferpallet) == 1) < find((priority.Data == upstreampallet) == 1)
                
                k=k+1;
				wait.Data(1) = 1;						%tell upstream to stop
				TransferArmRun(MOTOR_B, nxtT1, 105);
				start(clearPalletT1(k));				%start timer, which executes j2 = j2 - 1 after T1delay seconds.
				b1.Data(2) = b1.Data(2) - 1; 			%remove one pallet from transfer line section of buffer
				pause(0.8);
				wait.Data(1) = 0; 						%tell upstream to resume
				TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
			    
			
			%If pallet on mainline has priority, simply wait for it to clear.
			else
				while j1.Data(1) > 0
					pause(0.25);
					disp('mainline is busy')
				end
                k=k+1;
                TransferArmRun(MOTOR_B, nxtT1, 105);
                start(clearPalletT1(k)); %start timer, which executes j2 = j2 - 1 after T1delay seconds.
                b1.Data(2) = b1.Data(2) - 1; %remove one pallet from transfer line section of buffer
                pause(0.8);
                TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
                
			end
        else
            k=k+1;
            TransferArmRun(MOTOR_B, nxtT1, 105);
            start(clearPalletT1(k)); %start timer, which executes j2 = j2 - 1 after T1delay seconds.
            b1.Data(2) = b1.Data(2) - 1; %remove one pallet from transfer line section of buffer
            pause(0.8);
            TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, T1angle);
            
				
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