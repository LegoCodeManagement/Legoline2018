addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(6) = 49;
j3 = memmapfile('junction3.txt', 'Writable', true);
wait = memmapfile('wait.txt', 'Writable', true);

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_M',out{1})));
M2addr = char(out{2}(strcmp('Main2',out{1})));
M2delay = str2double(out{2}(strcmp('M2delay',out{1})));	
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
    pause(0.1);
end

ambientLight2 = GetLight(SENSOR_1, nxtM2);
mainline.SendToNXT(nxtM2);
%one timer for each pallet.

k=0;
%If pallet detected at start of mainline, wait for pallet to be detected at end.
%If not detected before timeout, display error.
while (k<23) && (fstatus.Data(1) == 49)

	if abs(GetLight(SENSOR_1, nxtM2) - ambientLight2) > 30 
		k = k+1; 
		m2.Data(1) = m2.Data(1) + 1;
		waitForPalletExit(nxtM2,SENSOR_1,ambientLight2,6)
	end
	
	%checktimeout
	
	if wait.Data(3) == 1
		mainline.Stop('off', nxtM2);
		while wait.Data(3) == 1
			pause(0.2);
		end
		mainline.SendToNXT(nxtM2);
	end
	
	waitForDetectionExit(nxtM2,SENSOR_1,4,Mthreshold) %cant use timer incase mainline stops.
	m2.Data(1) = m2.Data(1) - 1;
	
	%need to add: wait for pallet exit
	pause(0.1); %prevents updating to quickly
end

mainline.Stop('off', nxtM2);
disp('Main 2 STOPPED');
clear j3;
delete(timerfind);%Remove all timers from memory
CloseSensor(SENSOR_1, nxtM2);
CloseSensor(SENSOR_2, nxtM2);
COM_CloseNXT(nxtM2);