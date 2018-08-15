addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(9) = 49;
wait = memmapfile('wait.txt', 'Writable', true);

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_M',out{1})));
M3addr = char(out{2}(strcmp('Main3',out{1})));
%open connection and activate sensors
nxtM3 = COM_OpenNXTEx('USB', M3addr);
OpenLight(SENSOR_1, 'ACTIVE', nxtM3);
OpenLight(SENSOR_2, 'ACTIVE', nxtM3);


mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);
fstatus.Data(9) = 50;
disp('MAINLINE 3');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.1);
end

mainline.SendToNXT(nxtM3);

while (fstatus.Data(1) == 49)
	%tic
	[stdavg,avg,stdarray,array] = averagestd(nxtM3,SENSOR_2,stdarray,array);
	if stdavg < Mthreshold*0.5
		avg = ambient
	end

	if avg < ambient*0.9
		while avg < 0.85*ambient
			[stdavg,avg,stdarray,array] = averagestd(nxtM3,SENSOR_2,stdarray,array);
			pause(0.01)
		end
		removepallet('count_m3.txt')
	end

	pause(0.1); %prevents updating to quickly
end

mainline.Stop('off', nxtM3);
disp('Main 3 STOPPED');
CloseSensor(SENSOR_1, nxtM3);
CloseSensor(SENSOR_2, nxtM3);
COM_CloseNXT(nxtM3);
quit;
