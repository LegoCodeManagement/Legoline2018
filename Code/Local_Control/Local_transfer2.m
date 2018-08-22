addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(7) = 49;

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('line_speed',out{1})));
T2addr = char(out{2}(strcmp('Transfer2',out{1})));
T2angle = str2double(out{2}(strcmp('T2angle',out{1})));
T2delay = str2double(out{2}(strcmp('T2delay',out{1})));	
Tarmwait	= str2double(out{2}(strcmp('Tarmwait',out{1})));
Tthreshold = str2double(out{2}(strcmp('Tthreshold',out{1})));	
%open connection and activate sensors
nxtT2 = COM_OpenNXTEx('USB', T2addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT2);
OpenSwitch(SENSOR_2, nxtT2);
OpenLight(SENSOR_1, 'ACTIVE', nxtT2);

%allow feed to read and edit junction/buffer files
m1 = memmapfile('count_m1.txt', 'Writable', true, 'Format', 'int8');
m2 = memmapfile('count_m2.txt', 'Writable', true, 'Format', 'int8');
b2 = memmapfile('buffer2.txt', 'Writable', true, 'Format', 'int8');

TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);
fstatus.Data(7) = 50;
disp('TRANSFER 2');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.5);
end
%detect ambient light in room
currentLight1 = GetLight(SENSOR_1, nxtT2);
currentLight3 = GetLight(SENSOR_3, nxtT2);
%one timer for each pallet.
clearPalletT2 = [timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', T2delay);];

%run for 11 pallets or until told to stop
k=0;
while (fstatus.Data(1) == 49)
    %if we detect a pallet at start of transfer line, move it to transfer arm	
	if (abs(GetLight(SENSOR_1, nxtT2) - currentLight1) > 100)
    
		b2.Data(2) = b2.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT2, SENSOR_3, currentLight3, 10, Tthreshold);
		
		while m1.Data(1) > 48
			pause(0.5); %wait for mainline to be empty to transfer pallet
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
        k=k+1
		TransferArmRun(MOTOR_B, nxtT2, 100);
		start(clearPalletT2(k));%start timer, which executes m2 = m2 - 1 after T2delay seconds.
		pause(Tarmwait);
		m2.Data(1) = m2.Data(1) + 1;
		b2.Data(2) = b2.Data(2) - 1;
		TransferArmReset(MOTOR_B, SENSOR_2, nxtT2, T2angle);

        disp(['transfer buffer = ', num2str(b2.Data(2))]);
        disp(['feed buffer = ', num2str(b2.Data(1))]);
        disp(['junction 2 = ', num2str(m1.Data(1))]);
        
    end
	pause(0.2);
end

disp('Transfer 2 STOPPED')
delete(timerfind);
clearvars m1 m2 b2;
CloseSensor(SENSOR_1, nxtT2);
CloseSensor(SENSOR_2, nxtT2);
CloseSensor(SENSOR_3, nxtT2);
COM_CloseNXT(nxtT2);
quit;