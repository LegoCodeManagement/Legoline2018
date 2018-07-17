addpath RWTHMindstormsNXT;


fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(8) = 49;
b2 = memmapfile('buffer2.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

power = str2double(out{2}(strcmp('SPEED_F',out{1})));
F2addr = char(out{2}(strcmp('Feed2',out{1})));

nxtF2 = COM_OpenNXTEx('USB', F2addr);

OpenSwitch(SENSOR_1, nxtF2);
OpenLight(SENSOR_3, 'ACTIVE', nxtF2);


fstatus.Data(8) = 50;
disp('FEED 2');
disp('waiting for ready signal');
while fstatus.Data(1) == 48
    pause(0.1);
end

currentLight3 = GetLight(SENSOR_3, nxtF2);

T_F=7;
toc = T_F + 1; %start with a number greater than T_F so that feed starts immediately
k=0; 
while (k<6) && (fstatus.Data(1) == 49)
	if toc > T_F
		switch b2.Data(1)
			case 0
				feedPallet(nxtF2, SENSOR_1, MOTOR_A);
				
				if fstatus.Data(1) ~= 49
                    disp('break');
					break
				end
				
				k=k+1;
				clear toc
				tic %set timer for next pallet
				b2.Data(1) = b2.Data(1) + 1;
			
            case 1            
                movePalletSpacing(350, MOTOR_B, power, nxtF2);
                feedPallet(nxtF2, SENSOR_1, MOTOR_A);

                if fstatus.Data(1) ~= 49
                    disp('break');
					break
                end
				
				k=k+1;
				clear toc
				tic %set timer for next pallet
				b2.Data(1) = b2.Data(1) + 1;
				
			case 2
				disp(['cannot feed there are ',num2str(b2.Data(1)),' pallets on feed line']);
			
			otherwise
				disp(['error, there are ',num2str(b2.Data(1)),' pallets on feed line']);
				break;
		end
	end
	switch b2.Data(2)
		case 0
			switch b2.Data(1)
			
				case 0
					pause(0.1);
				case 1
					movePalletToLightSensor(MOTOR_B, power, nxtF2, SENSOR_3, currentLight3, 3);
					b2.Data(1) = b2.Data(1) - 1;
			
				case 2
					movePalletToLightSensor(MOTOR_B, power, nxtF2, SENSOR_3, currentLight3, 3);
					b2.Data(1) = b2.Data(1) - 1;
					movePalletSpacing(400, MOTOR_B, -power, nxtF2);
					
				otherwise
					disp(['error, there are ',num2str(b2.Data(1)),' pallets on feed line']);
					break;
			end
			
		case 1
		disp('waiting for pallet on transfer line');	
	end
	
	pause(0.2)  %to avoid update error
end

disp('Feed 2 STOPPED')
clear b2;
CloseSensor(SENSOR_1, nxtF2);
CloseSensor(SENSOR_3, nxtF2);
COM_CloseNXT(nxtF2);
			