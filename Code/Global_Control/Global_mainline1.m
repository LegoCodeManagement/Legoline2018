addpath RWTHMindstormsNXT;

%establish memory maps 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(3) = 49;
m1 		= memmapfile('count_m1.txt', 'Writable', true, 'Format', 'int8');
wait 	= memmapfile('wait.txt', 'Writable', true);

global fstatus
global wait

%open config file and save variable names and values column 1 and 2 respectively.
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);

%retrieve parameters
power 		= str2double(out{2}(strcmp('SPEED_M',out{1})));
M1addr		= char(out{2}(strcmp('Main1',out{1})));
M1delay 	= str2double(out{2}(strcmp('M1delay',out{1})));
Mthreshold 	= str2double(out{2}(strcmp('Mthreshold',out{1})));

%open connection and activate sensors
nxtM1 = COM_OpenNXTEx('USB', M1addr);
OpenLight(SENSOR_1, 'ACTIVE', nxtM1);
OpenLight(SENSOR_2, 'ACTIVE', nxtM1);

mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);
fstatus.Data(3) = 50;
disp('MAINLINE 1');
disp('waiting for ready signal');

%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.5);
end

mainline.SendToNXT(nxtM1);

array = ones(1,10)*GetLight(SENSOR_2,nxtM1);
stdarray = zeros(1,7);
stdavg = mean(stdarray);
ambient = array(1);

while (fstatus.Data(1) == 49)
	%tic
	[stdavg,avg,stdarray,array] = averagestd(nxtM1,SENSOR_2,stdarray,array);
	if stdavg > 10
		addpallet(m1.Data(1),'count_m2.txt')
		pause(0.01)
		removepallet('count_m1.txt')
		while (stdavg > 10) && (checkStop)
			pause(0.05)
			[stdavg,avg,stdarray,array] = averagestd(nxtM1,SENSOR_2,stdarray,array);
		end
		
		pause(0.08)
	end

	if (wait.Data(2) == 49) || (wait.Data(3) == 49)
		mainline.Stop('off', nxtM1);
		while ((wait.Data(2) == 49) || (wait.Data(3) == 49)) && (checkStop)
			pause(0.2);
		end
		mainline.SendToNXT(nxtM1);
	end

	pause(0.1); %prevents updating to quickly
end

mainline.Stop('off', nxtM1);
disp('Main 1 STOPPED');
clear m1;
delete(timerfind); %Remove all timers from memory
CloseSensor(SENSOR_1, nxtM1);
CloseSensor(SENSOR_2, nxtM1);
COM_CloseNXT(nxtM1);
quit;