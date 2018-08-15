addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(6) = 49;
m2 = memmapfile('count_m2.txt', 'Writable', true, 'Format', 'int8');
wait = memmapfile('wait.txt', 'Writable', true);
global wait
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
    pause(0.1);
end

ambientLight2 = GetLight(SENSOR_1, nxtM2);
mainline.SendToNXT(nxtM2);
%one timer for each pallet.

array = ones(1,10)*GetLight(SENSOR_2,nxtM2);
stdarray = zeros(1,7)
stdavg = mean(stdarray)
ambient = array(1);

while (fstatus.Data(1) == 49)
	%tic
	[stdavg,avg,stdarray,array] = averagestd(nxtM2,SENSOR_2,stdarray,array);
	if stdavg < Mthreshold*0.5
		avg = ambient
	end

	if wait.Data(3) == 1
		mainline.Stop('off', nxtM2);
		while wait.Data(3) == 1
			pause(0.2);
		end
		mainline.SendToNXT(nxtM2);
	end


	if avg < ambient*0.9
		addpallet(m2.Data(1),'count_m3.txt')
		while avg < 0.85*ambient
			[stdavg,avg,stdarray,array] = averagestd(nxtM2,SENSOR_2,stdarray,array);
			pause(0.01)
		end
		removepallet('count_m2.txt')
	end

	pause(0.1); %prevents updating to quickly
end

mainline.Stop('off', nxtM2);
disp('Main 2 STOPPED');
clear m2;
delete(timerfind);%Remove all timers from memory
CloseSensor(SENSOR_1, nxtM2);
CloseSensor(SENSOR_2, nxtM2);
COM_CloseNXT(nxtM2);
quit;