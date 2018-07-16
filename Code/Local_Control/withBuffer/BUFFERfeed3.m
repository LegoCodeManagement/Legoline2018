COM_CloseNXT('all');
disp('Running Feed3');
nxtF1Addr = '0016530D6831';
nxtF1 = COM_OpenNXTEx('USB', nxtF1Addr);

power = linepower;

OpenSwitch(SENSOR_1, nxtF1);
OpenLight(SENSOR_3, 'ACTIVE', nxtF1);

b1 = memmapfile('buffer1.txt', 'Writable', true, 'Format', 'int8');

%clear buffer data
b1.Data(1) = 0;
b1.Data(2) = 0;

input('press ENTER to start');

currentLight3 = GetLight(SENSOR_3, nxtF1);


T_F=10;
toc = T_F + 1; %start with a number greater than 10 so that feed starts immediately
k=0; 
while k < 5 	%run loop until 4 pallets have been outputted.
	if toc > T
		switch b1.Data(1)
			case b1.Data(1) == 1 | b1.Data(1) == 0
				feedPallet(nxtF1, SENSOR_1, MOTOR_A);
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

disp('feed 1 STOPPED')
clear b1;
CloseSensor(SENSOR_1, nxtF1);
CloseSensor(SENSOR_3, nxtF1);
COM_CloseNXT(nxtF1);
			