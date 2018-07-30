addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(2) = 49; %initalise

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_U',out{1})));
Uaddr = char(out{2}(strcmp('Upstream',out{1})));
Udelay = str2double(out{2}(strcmp('Udelay',out{1})));	
T_U = str2double(out{2}(strcmp('T_U',out{1})));	
nxtU = COM_OpenNXTEx('USB', Uaddr);


%establish memory map to junction file
u = memmapfile('count_u.txt','Writable',true);
disp(u.Data(1));

OpenLight(SENSOR_2,'ACTIVE',nxtU);
OpenSwitch(SENSOR_1,nxtU);
fstatus.Data(2) = 50; %ready
disp('UPSTREAM');
disp('waiting for ready signal')
while fstatus.Data(1) == 48
    pause(0.1); %wait for ready sign
end
currentValueU = GetLight(SENSOR_2,nxtU);
%one timer for each pallet.

palletHasLeft = [timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay); 
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay);
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay); 
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay);
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay); 
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay);
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay); 
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay);
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay);
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay); 
                 timer('TimerFcn','u.Data(1) = u.Data(1) - 1;','StartDelay',Udelay);];

toc = T_U + 1;
k=0;
while (k<12) && (fstatus.Data(1) == 49)
    
	if (toc > T_U)
        clear toc
		tic;
		feedPallet(nxtU,SENSOR_1,MOTOR_A);
		u.Data(1) = u.Data(1) + 1;
        
        if fstatus.Data(1) ~= 49
            break
            disp('break');
        end
        
        k=k+1;
        movePalletPastLightSensor(MOTOR_B,power,nxtU,SENSOR_2,currentValueU,3,11);
        start(palletHasLeft(k))
        
    end
        %take movepallet outside if statement and make new: if u.Data(1) > 1 then movepallet.
        
	pause(0.1)
end

delete(timerfind);
disp('Upstream STOPPED')
clear u;
CloseSensor(SENSOR_1, nxtU);
CloseSensor(SENSOR_2, nxtU);
COM_CloseNXT(nxtU);
quit;