addpath RWTHMindstormsNXT;

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);


power = str2double(out{2}(strcmp('SPEED_U',out{1})));
Uaddr = char(out{2}(strcmp('Upstream',out{1})));

nxtU = COM_OpenNXTEx('USB', Uaddr);


fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
j1 = memmapfile('Junction1.txt','Writable',true);
disp(j1.Data(1));

OpenLight(SENSOR_2,'ACTIVE',nxtU)
OpenSwitch(SENSOR_1,nxtU)


disp('UPSTREAM');

disp('waiting for ready signal')

while fstatus.Data(1) == 48
    pause(0.1);
end
currentValueU = GetLight(SENSOR_2,nxtU);

palletHasLeft = [timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3);
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3);
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3);
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3)];

T_U = 6;
toc = T_U + 1;
j=0;
tic;
while (j<6) && (fstatus.Data(1) == 49)
    
	if toc > T_U
		j1.Data(1) = j1.Data(1) + 1;
		clear toc
		tic
		feedPallet(nxtU,SENSOR_1,MOTOR_A);
		j=j+1;
        if fstatus.Data(1) ~= 49
            break
            disp('break');
        end
		movePalletToLightSensor(MOTOR_B,power,nxtU,SENSOR_2,currentValueU,20);
		start(palletHasLeft(j));
	end
	pause(0.25)
end

delete(timerfind);
disp('Upstream STOPPED')
clear j1;
CloseSensor(SENSOR_1, nxtU);
CloseSensor(SENSOR_2, nxtU);
COM_CloseNXT(nxtU);
