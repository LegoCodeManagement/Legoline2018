addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(5) = 49;
b1 = memmapfile('buffer1.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2 respectively.
cd(['..',filesep])
config = fopen('config.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(config, '%s %s %s %s %s');
fclose(config);
%retrieve parameters
power 		= str2double(out{2}(strcmp('line_speed',out{1})));
F1addr 		= char(out{2}(strcmp('Feed1',out{1})));
T_F1 		= str2double(out{2}(strcmp('T_F1',out{1})));
Fthreshold 	= str2double(out{2}(strcmp('Fthreshold',out{1})));	
nxtF1 		= COM_OpenNXTEx('USB', F1addr);
clear out

cd(['..',filesep])
param = fopen('Parameters.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(param, '%s %s %s %s %s');
fclose(param);
row 	= find(strcmp('ControlLine1',out{1}));

dist    = char(out{2}(row));
param1  = str2double(out{3}(row));
param2  = str2double(out{4}(row));
param3  = str2double(out{5}(row));
row 	= find(strcmp('Line1',out{1}));
%buffer is line 3
buffer 	= str2double(out{4}(row));

%activate sensors
OpenSwitch(SENSOR_1, nxtF1);
OpenLight(SENSOR_3, 'ACTIVE', nxtF1);

%signal that this module is ready
fstatus.Data(5) = 50;
disp('FEED 1');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.3);
end

%calculate the background light in the room. 
%Further measurements will be measured as a difference to this.
currentLight3 = GetLight(SENSOR_3, nxtF1);

timer1 = tic;
timer2 = tic;
feed_time = 0;
k=0;
%feed all the pallets or until told to stop.
while (k<12) && (fstatus.Data(1) == 49) 
	if (toc(timer1) >= feed_time) %true if it's time to feed

		if b1.Data(1) == 48
			b1.Data(1) = b1.Data(1) + 1;
			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feed_time)]);
			feedPallet(nxtF1, SENSOR_1, MOTOR_A);
			k=k+1;
			timer1 = tic
			feed_time = feedtime(dist,param1,param2,param3);
			
		elseif b1.Data(1) < 48+buffer     
			movePalletSpacing(400, MOTOR_B, power, nxtF1); %move this into statement above?
			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feed_time)]);
			b1.Data(1) = b1.Data(1) + 1;
			feedPallet(nxtF1, SENSOR_1, MOTOR_A);
			k=k+1;
			timer1 = tic
			feed_time = feedtime(dist,param1,param2,param3);
				
		elseif b1.Data(1) == 48+buffer
			disp(['cannot feed there are ',num2str(b1.Data(1)-48),' pallets on feed line']);
			logwrite(['buffer exceeded, there were ',num2str(b1.Data(1)-48),' pallets on feed line 1']);
			fstatus.Data(1)=50;
			break;
			
		else
			disp(['error, there are ',num2str(b1.Data(1)-48),' pallets on feed line 1']);
			logwrite(['error, there are ',num2str(b1.Data(1)-48),' pallets on feed line 1']);
			fstatus.Data(1)=50;
			break;
		end
	end
	switch b1.Data(2)
        case 48
			switch b1.Data(1)
				case 48
					pause(0.1);
				case 49
					movePalletPastLSfeed(MOTOR_B, power, nxtF1, SENSOR_3, 6, Fthreshold);
					b1.Data(1) = b1.Data(1) - 1;
                case 50 
                	movePalletSpacing(500, MOTOR_B, power, nxtF1);
                	pause(1);
                	b1.Data(1) = b1.Data(1) - 1;
					movePalletSpacing(450, MOTOR_B, -power, nxtF1); %move pallet back on feed line so two can fit
					
				otherwise
					disp(['error, there are ',num2str(48-b1.Data(1)),' pallets on feed line 1']);
					logwrite(['error, there were ',num2str(48-b1.Data(1)),' pallets on feed line 1']);
					break;
			end
			
        case 49
        pause(0.1);
	end
	pause(0.2)  %to avoid update error
end

disp('Feed 1 STOPPED')
clear b1;
CloseSensor(SENSOR_1, nxtF1);
CloseSensor(SENSOR_3, nxtF1);
COM_CloseNXT(nxtF1);
quit;			