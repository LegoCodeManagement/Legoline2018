addpath RWTHMindstormsNXT;

%establish memory maps
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(9) = 49;
wait 	= memmapfile('wait.txt', 'Writable', true);


global fstatus


%open config file and save variable names and values column 1 and 2 respectively.
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);

%retrieve parameters
power 	= str2double(out{2}(strcmp('line_speed',out{1})));
M3addr 	= char(out{2}(strcmp('Main3',out{1})));



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
    pause(0.5);
end

mainline.SendToNXT(nxtM3);

array = ones(1,10)*GetLight(SENSOR_2,nxtM3);
stdarray = zeros(1,7)
stdavg = mean(stdarray)
ambient = array(1);

while (fstatus.Data(1) == 49)
	%tic
	[stdavg,avg,stdarray,array] = averagestd(nxtM3,SENSOR_2,stdarray,array);
	if stdavg > 10
		while stdavg > 10
			pause(0.05)
			[stdavg,avg,stdarray,array] = averagestd(nxtM3,SENSOR_2,stdarray,array);
		end
		removepallet('count_m3.txt')
		pause(0.08)
	end
	
	if m3.Data(1) == 48
	mainline.Stop('off', nxtM3);
		while m3.Data(1) == 48
			pause(0.2);
		end
	mainline.SendToNXT(nxtM3);
	end

	pause(0.1); %prevents updating to quickly
end

mainline.Stop('off', nxtM3);
disp('Main 3 STOPPED');
CloseSensor(SENSOR_1, nxtM3);
CloseSensor(SENSOR_2, nxtM3);
COM_CloseNXT(nxtM3);
quit;
