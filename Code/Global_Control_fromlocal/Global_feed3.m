addpath RWTHMindstormsNXT;
%establish memory map to status.txt.
b3 = memmapfile('buffer3.txt', 'Writable', true, 'Format', 'int8');
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(11) = 49;

%open config file and save variable names and values column 1 and 2 respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
power		= str2double(out{2}(strcmp('SPEED_F',out{1})));
F3addr		= char(out{2}(strcmp('Feed3',out{1})));
T_F3		= str2double(out{2}(strcmp('T_F3',out{1})));
Fthreshold 	= str2double(out{2}(strcmp('Fthreshold',out{1})));	
nxtF3		= COM_OpenNXTEx('USB', F3addr);

%activate sensors
OpenSwitch(SENSOR_1, nxtF3);
OpenLight(SENSOR_3, 'ACTIVE', nxtF3);

%signal that this module is ready
fstatus.Data(11) = 50;
disp('FEED 3');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.5);
end

%calculate the background light in the room. Further measurements will be measured as a difference to this.
currentLight3 = GetLight(SENSOR_3, nxtF3);

%feed all the pallets or until told to stop.
toc = T_F3;

while (fstatus.Data(1) == 49)
	if (toc >= T_F3) %true if it's time to feed
		switch b3.Data(1)
			case 48
				b3.Data(1) = b3.Data(1) + 1;
				feedPallet(nxtF3, SENSOR_1, MOTOR_A);
				clear toc;
				tic;
			
            case 49            
                movePalletSpacing(400, MOTOR_B, power, nxtF3); %move pallet already on feed line out the way
                feedPallet(nxtF3, SENSOR_1, MOTOR_A);
				clear toc;
				tic;
				b3.Data(1) = b3.Data(1) + 1;
							
			case 50
				disp(['cannot feed there are ',num2str(b3.Data(1)),' pallets on feed line']);
			
			otherwise
				disp(['error, there are ',num2str(b3.Data(1)),' pallets on feed line']);
				break;
		end
	end
	switch b3.Data(2)
		case 48
			switch b3.Data(1)
				case 48
					pause(0.1);
				case 49
					movePalletPastLSfeed(MOTOR_B, power, nxtF3, SENSOR_3, 6, Fthreshold);
					b3.Data(1) = b3.Data(1) - 1;
                    disp('attempting to move pallet to LS')
				case 50
					movePalletSpacing(500, MOTOR_B, power, nxtF3);
					pause(1);
					
					b3.Data(1) = b3.Data(1) - 1;
					movePalletSpacing(350, MOTOR_B, -power, nxtF3);
					
				otherwise
					disp(['error, there are ',num2str(b3.Data(1)),' pallets on feed line']);
					break;
			end
			
		case 49
		disp('waiting for pallet on transfer line');
        disp(['transfer buffer = ', num2str(b3.Data(2))]);
        disp(['feed buffer = ', num2str(b3.Data(1))]);
        disp(' ');
        pause(0.3);	
	end
	
	pause(0.2)  %to avoid update error
end

disp('Feed 3 STOPPED')
clear b3;
CloseSensor(SENSOR_1, nxtF3);
CloseSensor(SENSOR_3, nxtF3);
COM_CloseNXT(nxtF3);
quit;