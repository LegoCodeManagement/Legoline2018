addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(3) = 49;
global fstatus
m1 = memmapfile('count_m1.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('line_speed',out{1})));
M1addr = char(out{2}(strcmp('Main1',out{1})));
M1delay = str2double(out{2}(strcmp('M1delay',out{1})));	
Mthreshold = str2double(out{2}(strcmp('Mthreshold',out{1})));	
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

ambientLight1 = GetLight(SENSOR_1, nxtM1);

%one timer for each pallet.

%If pallet detected at start of mainline, wait for pallet to be detected at end.
%If not detected before timeout, display error.

array = ones(1,10)*GetLight(SENSOR_1,nxtM1);
stdarray = zeros(1,7);
stdavg = mean(stdarray);

array2 = ones(1,10)*GetLight(SENSOR_1,nxtM1);
stdarray2 = zeros(1,7);
stdavg2 = mean(stdarray);

while (fstatus.Data(1) == 49) && (checkStop)

	[stdavg,avg,stdarray,array] 	= averagestd(nxtM1,SENSOR_1,stdarray,array);
	[stdavg2,avg2,stdarray2,array2] = averagestd(nxtM1,SENSOR_2,stdarray2,array2);
	
	if stdavg > Mthreshold && busy == 0
		if m1.Data(1) == 48
			mainline.SendToNXT(nxtM1);
		end
		m1.Data(1) = m1.Data(1) + 1;
		busy = 1;
	end
	
	if stdavg2 > Mthreshold && busy2 == 0
		m1.Data(1) = m1.Data(1) - 1;
		if m1.Data(1) == 48
			mainline.Stop('off', nxtM1);
		end
		busy = 1;
	end
	
	if (busy == 1) && (stdavg < Mthreshold*0.5)
		busy = 0;
	end
    
    if (busy2 == 1) && (stdavg2 < Mthreshold*0.5)
		busy2 = 0;
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