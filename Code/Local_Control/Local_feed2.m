addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
global fstatus
fstatus.Data(8) = 49;
b2 = memmapfile('buffer2.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2 respectively.
cd(['..',filesep])
config = fopen('config.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(config, '%s %s %s %s %s');
fclose(config);
%retrieve parameters
power 		= str2double(out{2}(strcmp('line_speed',out{1})));
F2addr 		= char(out{2}(strcmp('Feed2',out{1})));
Fthreshold 	= str2double(out{2}(strcmp('Fthreshold',out{1})));	
nxtF2		= COM_OpenNXTEx('USB', F2addr);
clear out

cd(['..',filesep])
param = fopen('Parameters.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(param, '%s %s %s %s %s');
fclose(param);

row 	= find(strcmp('ControlLine2',out{1}));
dist    = char(out{2}(row));
param1  = str2double(out{3}(row));
param2  = str2double(out{4}(row));
param3  = str2double(out{5}(row));
row 	= find(strcmp('Line2',out{1}));
%buffer is line 3
buffer 	= str2double(out{4}(row))-1;

%activate sensors
OpenSwitch(SENSOR_1, nxtF2);
OpenLight(SENSOR_3, 'ACTIVE', nxtF2);

%signal that this module is ready
fstatus.Data(8) = 50;
disp('FEED 2');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.3);
end
disp('Feed 2 has started!')
%calculate the background light in the room. Further measurements will be measured as a difference to this.
currentLight3 = GetLight(SENSOR_3, nxtF2);

timer1 = tic;
timer2 = tic;
feed_time = 0;
k=0;
%feed all the pallets or until told to stop.
while (k<12) && (fstatus.Data(1) == 49)
	if (toc(timer1) >= feed_time) %true if it's time to feed
		if b2.Data(1) == 48
			b2.Data(1) = b2.Data(1) + 1;
			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feed_time)]);
			feedPallet(nxtF2, SENSOR_1, MOTOR_A);
            movePalletSpacing(410, MOTOR_B, power, nxtF2);
			k=k+1;
			timer1 = tic;
			feed_time = feedtime(dist,param1,param2,param3);
		
		elseif b2.Data(1) < 48+buffer       
			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feed_time)]);
			b2.Data(1) = b2.Data(1) + 1;
			feedPallet(nxtF2, SENSOR_1, MOTOR_A);
			k=k+1;
			timer1 = tic;
			feed_time = feedtime(dist,param1,param2,param3);
				
		elseif b2.Data(1) == 48+buffer
			disp(['cannot feed there are ',num2str(b2.Data(1)-48),' pallets on feed line']);
			logwrite(['buffer exceeded, there were ',num2str(b2.Data(1)-48),' pallets on feed line 2']);
			fstatus.Data(1)=50;
			break;
			
		else
			disp(['error, there are ',num2str(b2.Data(1)-48),' pallets on feed line 2']);
			logwrite(['error, there were ',num2str(b2.Data(1)-48),' pallets on feed line 2']);
			fstatus.Data(1)=50;
			break;
		end
	end
	pause(0.05)
	switch b2.Data(2)
		case 48
			switch b2.Data(1)
				case 48
					pause(0.1);
				case 49
					movePalletPastLSfeed(MOTOR_B, power, nxtF2, SENSOR_3, 6, Fthreshold);
					b2.Data(1) = b2.Data(1) - 1;
				case 50
					movePalletSpacing(460, MOTOR_B, power, nxtF2);
					pause(1);
					b2.Data(1) = b2.Data(1) - 1;
					
				otherwise
					disp(['error, there are ',num2str(b2.Data(1)-48),' pallets on feed line']);
					logwrite(['error, there were ',num2str(b2.Data(1)-48),' pallets on feed line 2']);
					break;
			end
			
		case 49
        pause(0.1);
	end
	
	pause(0.2)  %to avoid update error
end

disp('Feed 2 STOPPED')
clear b2;
CloseSensor(SENSOR_1, nxtF2);
CloseSensor(SENSOR_3, nxtF2);
COM_CloseNXT(nxtF2);
quit;