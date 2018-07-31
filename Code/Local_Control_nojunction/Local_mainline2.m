addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(6) = 49;
m2 = memmapfile('count_m2.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_M',out{1})));
M2addr = char(out{2}(strcmp('Main2',out{1})));
M2delay = str2double(out{2}(strcmp('M2delay',out{1})));	
Mthreshold = str2double(out{2}(strcmp('Mthreshold',out{1})));	
%open connection and activate sensors
nxtM2 = COM_OpenNXTEx('USB', M2addr);
OpenLight(SENSOR_1, 'ACTIVE', nxtM2);
OpenLight(SENSOR_2, 'ACTIVE', nxtM2);


mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);
fstatus.Data(6) = 50;
disp('MAINLINE 2');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.5);
end

ambientLight2 = GetLight(SENSOR_1, nxtM2);
mainline.SendToNXT(nxtM2);
%one timer for each pallet.
clearPalletM = [timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);
                timer('TimerFcn', 'm2.Data(1) = m2.Data(1) - 1;', 'StartDelay', M2delay);];


%If pallet detected at start of mainline, wait for pallet to be detected at end.
%If not detected before timeout, display error.

k=0;
array = ones(1,10)*GetLight(port,nxt);
avg = mean(array);
while (fstatus.Data(1) == 49)

	waitForDetectionExit(nxtM2, SENSOR_1, ambientLight2, 4, Mthreshold);
	
	k=k+1;
	disp(['pallet detected. Pallets on mainline 2: ',num2str(m2.Data(1)-48)]);
	start(clearPalletM(k)); %start timer, which executes m2 = m2 - 1 after M1delay seconds.
	pause(0.5)
	m2.Data(1) = m2.Data(1) + 1;
	
	if fstatus.Data(1) ~= 49
        break
		disp('break');
    end
    
	pause(0.2); %prevents updating to quickly
end

mainline.Stop('off', nxtM2);
disp('Main 2 STOPPED');
clear m2;
delete(timerfind);%Remove all timers from memory
CloseSensor(SENSOR_1, nxtM2);
CloseSensor(SENSOR_2, nxtM2);
COM_CloseNXT(nxtM2);
quit;