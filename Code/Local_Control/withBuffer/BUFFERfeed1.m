addpath RWTHMindstormsNXT;

COM_CloseNXT('all')

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

power = str2double(out{2}(strcmp('SPEED_F',out{1})));
F1addr = char(out{2}(strcmp('Feed1',out{1})));

nxtF1 = COM_OpenNXTEx('USB', F1addr);

OpenSwitch(SENSOR_1, nxtF1);
OpenLight(SENSOR_3, 'ACTIVE', nxtF1);

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
b1 = memmapfile('buffer1.txt', 'Writable', true, 'Format', 'int8');

disp('FEED 1');
input('press ENTER to start');

currentLight3 = GetLight(SENSOR_3, nxtF1);


T_F=10;
toc = T_F + 1; %start with a number greater than 10 so that feed starts immediately
k=0; 
while (k<6) && (fstatus.Data(1) == 49)
	if toc > T
		switch b1.Data(1)
			case b1.Data(1) == 1 | b1.Data(1) == 0
				feedPallet(nxtF1, SENSOR_1, MOTOR_A);
				
				if fstatus.Data(1) ~= 49
					break
					disp('break');
      			end
				
				k=k+1;
				clear toc
				tic %set timer for next pallet
				b1.Data(1) = b1.Data(1) + 1;
				
				
			case b1.Data(1) == 2
				disp(['cannot feed there are ',num2str(b1.Data(1)),' pallets on feed line']);
			
			otherwise
				disp(['error, there are ',num2str(b1.Data(1)),' pallets on feed line']);
				break;
		end
	
	switch b1.Data(2)
		case b1.Data(2) == 0
			switch b1.Data(1)
			
				case b1.Data(1) == 0
					
				case b1.Data(1) == 1
					movePalletToLightSensor(MOTOR_B, power, nxtF1, SENSOR_3, currentLight3, 3);
					b1.Data(1) = b1.Data(1) - 1;
			
				case b1.Data(1) == 2 
					movePalletToLightSensor(MOTOR_B, power, nxtF1, SENSOR_3, currentLight3, 3);
					b1.Data(1) = b1.Data(1) - 1;
					movePalletSpacing(400, MOTOR_B, -power, nxtF1);
					
				otherwise
					disp(['error, there are ',num2str(b1.Data(1)),' pallets on feed line']);
					break;
			end
			
		case b1.Data(2) == 1
		disp('waiting for pallet on transfer line');	
	end
	
	pause(0.2)  %to avoid update error
	
end

disp('Feed 2 STOPPED')
clear b1;
CloseSensor(SENSOR_1, nxtF1);
CloseSensor(SENSOR_3, nxtF1);
COM_CloseNXT(nxtF1);
			