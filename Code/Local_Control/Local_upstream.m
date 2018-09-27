addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(2) = 49;
u = memmapfile('u.txt','Writable',true,'Format','int8');

%open config file and save variable names and values column 1 and 2 respectively.
cd(['..',filesep])
config = fopen('config.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(config, '%s %s %s %s %s');
fclose(config);
%retrieve parameters
power 		= str2double(out{2}(strcmp('line_speed',out{1})));
Uaddr 		= char(out{2}(strcmp('Upstream',out{1})));
Udelay 		= str2double(out{2}(strcmp('Udelay',out{1})));	
Uthreshold 	= str2double(out{2}(strcmp('Uthreshold',out{1})));	
nxtU = COM_OpenNXTEx('USB', Uaddr);
clear out

cd(['..',filesep])
param = fopen('Parameters.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(param, '%s %s %s %s %s');
fclose(param);

row 	= find(strcmp('ControlUpstr',out{1}));
dist    = char(out{2}(row));
param1  = str2double(out{3}(row));
param2  = str2double(out{4}(row));
param3  = str2double(out{5}(row));

OpenLight(SENSOR_2,'ACTIVE',nxtU);
OpenSwitch(SENSOR_1,nxtU);
fstatus.Data(2) = 50; %ready
disp('Local Upstream');
disp('waiting for ready signal')
while fstatus.Data(1) == 48
    pause(0.1); %wait for ready sign
end
disp('Upstream has started!')
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

timer1 = tic;
timer2 = tic;
feed_time = 0;
k=0;
%feed all the pallets or until told to stop.
while (k<12) && (fstatus.Data(1) == 49)
	if (toc(timer1) > feed_time)
		u.Data(1) = u.Data(1) + 1;
        disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feed_time)]);
		feedPallet(nxtU,SENSOR_1,MOTOR_A);
		k=k+1;
        timer1 = tic;
		feed_time = feedtime(dist,param1,param2,param3);
        movePalletPastLSupstream(MOTOR_B,power,nxtU,SENSOR_2,5,Uthreshold);
        start(palletHasLeft(k));
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