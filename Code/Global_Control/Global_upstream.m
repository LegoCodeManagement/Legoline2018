addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus	= memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
wait 	= memmapfile('wait.txt', 'Writable', true, 'Format', 'int8');
u1 		= memmapfile('count_u1.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(2) = 49;
global fstatus

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

%retrieve parameters
power 			= str2double(out{2}(strcmp('line_speed',out{1})));
Uaddr			= char(out{2}(strcmp('Upstream',out{1})));
Udelay			= str2double(out{2}(strcmp('Udelay',out{1})));	
T_U				= str2double(out{2}(strcmp('T_U',out{1})));	
Uthreshold		= str2double(out{2}(strcmp('Uthreshold',out{1})));	
nxtU			= COM_OpenNXTEx('USB', Uaddr);
upstreampallet 	= 49;

movePallet = NXTMotor(MOTOR_B, 'Power', power);
movePallet.SpeedRegulation = 0;

OpenLight(SENSOR_2,'ACTIVE',nxtU);
OpenSwitch(SENSOR_1,nxtU);
fstatus.Data(2) = 50; %ready
disp('UPSTREAM');
disp('waiting for ready signal');

while fstatus.Data(1) == 48
    pause(0.1); %wait for ready sign
end

upstreampallet = 49;

toc = T_U + 1;

array = ones(1,10)*GetLight(SENSOR_2,nxtU);
stdarray = zeros(1,7);
stdavg = mean(stdarray);

while (fstatus.Data(1) == 49)
    
	if (toc > T_U)
		clear toc
		%tic;
		feedPallet(nxtU,SENSOR_1,MOTOR_A);
		addpallet(upstreampallet,'count_u1.txt')
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		movePallet.SendToNXT(nxtU);

		while stdavg < Uthreshold
		
			if (wait.Data(1) == 49) || (wait.Data(2) == 49) || (wait.Data(3) == 49)
				movePallet.Stop('off',nxtU);
				while ((wait.Data(1) == 49) || (wait.Data(2) == 49) || (wait.Data(3) == 49)) && (checkStop)
					pause(0.2);
				end
				movePallet.SendToNXT(nxtU);
			end

			[stdavg,avg,stdarray,array] = averagestd(nxtU,port,stdarray,array);
			pause(0.02)
			%checkTimeOut(timeOut)
		end
		%tic;
		while stdavg > Uthreshold*0.5
			[stdavg,avg,stdarray,array] = averagestd(nxtU,port,stdarray,array);
			pause(0.02)
			%checkTimeOut(timeOut)
		end
		movePallet.Stop('off', nxtU);

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		addpallet(upstreampallet,'count_m1.txt')
        pause(0.3);
        removepallet('count_u1.txt')
		
	end
	pause(0.1)
end

delete(timerfind);
disp('Upstream STOPPED')
clear u1;
CloseSensor(SENSOR_1, nxtU);
CloseSensor(SENSOR_2, nxtU);
COM_CloseNXT(nxtU);
quit;