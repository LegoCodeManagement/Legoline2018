addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
b1 = memmapfile('buffer1.txt', 'Writable', true, 'Format', 'int8');
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(5) = 49;

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
power 		 = str2double(out{2}(strcmp('SPEED_F',out{1})));
F1addr 		 = char(out{2}(strcmp('Feed1',out{1})));
T_F1 		 = str2double(out{2}(strcmp('T_F1',out{1})));
Fthreshold   = str2double(out{2}(strcmp('Fthreshold',out{1})));	
nxtF1 		 = COM_OpenNXTEx('USB', F1addr);

dist = char(out{2}(strcmp('feed_distribution',out{1})));

%activate sensors
OpenSwitch(SENSOR_1, nxtF1);
OpenLight(SENSOR_3, 'ACTIVE', nxtF1);

%signal that this module is ready
fstatus.Data(5) = 50;
disp('FEED 1');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.5);
end

%calculate the background light in the room.
%Further measurements will be measured as a difference to this.
currentLight3 = GetLight(SENSOR_3, nxtF1);

%feed all the pallets or until told to stop.

timer1 = tic;
timer2 = tic;
feedtime = 0;
lower = T_F1 - 3;
upper = T_F1 + 3;

while (fstatus.Data(1) == 49) 
	if (toc(timer1) >= feedtime) %true if it's time to feed
		switch b1.Data(1)
    		case 48
                b1.Data(1) = b1.Data(1) + 1;
				disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feedtime)]);
				feedPallet(nxtF1, SENSOR_1, MOTOR_A);
				timer1 = tic;
				switch dist %dist will never change unless file is re-read
							%but switch statement repeatedly checks value of dist - inefficient?
					case 1
						feedtime = T_F1;
					case 2
						feedtime = poissrnd(T_F1);
					case 3
						feedtime = randraw('tri',[lower,T_F1,upper],1);
					otherwise
						disp('error, wrong input distribution')
				end

            case 49  
        		b1.Data(1) = b1.Data(1) + 1;          
                movePalletSpacing(400, MOTOR_B, power, nxtF1); %move pallet already on feed line out the way
                feedPallet(nxtF1, SENSOR_1, MOTOR_A);
				timer1 = tic;
				switch dist
					case 1
						feedtime = T_F1;
					case 2
						feedtime = poissrnd(T_F1);
					case 3
						feedtime = randraw('tri',[lower,T_F1,upper],1);
					otherwise
						disp('error, wrong input distribution')
				end
				
            case 50
				disp(['cannot feed there are ',num2str(b1.Data(1)),' pallets on feed line']);
			
			otherwise
				disp(['error, there are ',num2str(b1.Data(1)),' pallets on feed line']);
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
					disp('pushing one pallet to transfer line')
					b1.Data(1) = b1.Data(1) - 1;
                case 50
                	movePalletSpacing(500, MOTOR_B, power, nxtF1);
                	pause(1);
					b1.Data(1) = b1.Data(1) - 1;
					movePalletSpacing(450, MOTOR_B, -power, nxtF1); %move pallet back on feed line so two can fit
					
				otherwise
					disp(['error, there are ',num2str(b1.Data(1)),' pallets on feed line']);
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