addpath RWTHMindstormsNXT;


fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(11) = 49;
b3 = memmapfile('buffer3.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

power = str2double(out{2}(strcmp('SPEED_F',out{1})));
F3addr = char(out{2}(strcmp('Feed3',out{1})));

nxtF3 = COM_OpenNXTEx('USB', F3addr);

OpenSwitch(SENSOR_1, nxtF3);
OpenLight(SENSOR_3, 'ACTIVE', nxtF3);


fstatus.Data(11) = 50;
disp('FEED 3');
disp('waiting for ready signal');
while fstatus.Data(1) == 48
    pause(0.1);
end

currentLight3 = GetLight(SENSOR_3, nxtF3);

T_F=10;
toc = T_F + 1; %start with a number greater than T_F so that feed starts immediately
k=0; 
while (k<6) && (fstatus.Data(1) == 49)
	if toc > T_F
		switch b3.Data(1)
			case 0
				feedPallet(nxtF3, SENSOR_1, MOTOR_A);
				
				if fstatus.Data(1) ~= 49
                    disp('break');
					break
				end
				
				k=k+1;
				clear toc
				tic %set timer for next pallet
				b3.Data(1) = b3.Data(1) + 1;
			
            case 1            
                movePalletSpacing(350, MOTOR_B, power, nxtF3);
                feedPallet(nxtF3, SENSOR_1, MOTOR_A);

                if fstatus.Data(1) ~= 49
                    disp('break');
					break
                end
				
				k=k+1;
				clear toc
				tic %set timer for next pallet
				b3.Data(1) = b3.Data(1) + 1;
							
			case  2
				disp(['cannot feed there are ',num2str(b3.Data(1)),' pallets on feed line']);
			
			otherwise
				disp(['error, there are ',num2str(b3.Data(1)),' pallets on feed line']);
				break;
		end
	end
	switch b3.Data(2)
		case 0
			switch b3.Data(1)
			
				case 0
					pause(0.1)
				case 1
					movePalletToLightSensor(MOTOR_B, power, nxtF3, SENSOR_3, currentLight3, 3);
					b3.Data(1) = b3.Data(1) - 1;
			
				case 2
					movePalletToLightSensor(MOTOR_B, power, nxtF3, SENSOR_3, currentLight3, 3);
					b3.Data(1) = b3.Data(1) - 1;
					movePalletSpacing(400, MOTOR_B, -power, nxtF3);
					
				otherwise
					disp(['error, there are ',num2str(b3.Data(1)),' pallets on feed line']);
					break;
			end
			
		case 1
		disp('waiting for pallet on transfer line');	
	end
	
	pause(0.2)  %to avoid update error
end

disp('Feed 3 STOPPED')
clear b3;
CloseSensor(SENSOR_1, nxtF3);
CloseSensor(SENSOR_3, nxtF3);
COM_CloseNXT(nxtF3);
			