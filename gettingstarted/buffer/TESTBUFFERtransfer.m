COM_CloseNXT('all');
disp('Running transfer 1');
nxtT1Addr = '0016530AABDF';
nxtT1 = COM_OpenNXTEx('USB', nxtT1Addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT1);
OpenSwitch(SENSOR_2, nxtT1);
OpenLight(SENSOR_1, 'ACTIVE', nxtT1);

TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, 16);
j = memmapfile('Junction1.txt', 'Writable', true);

b = memmapfile('buffer.txt', 'Writable', true, 'Format', 'int8');

currentLight1 = GetLight(SENSOR_1, nxtT1);
currentLight3 = GetLight(SENSOR_3, nxtT1);

disp('transfer')
input('press ENTER to start')
k=0;
while k < 6

    	
	if (abs(GetLight(SENSOR_1, nxtT1) - currentLight1) > 11)
		if b.Data(2) == 0
            
            b.Data(1) = b.Data(1) - 1;
            b.Data(2) = b.Data(2) + 1;
            
			movePalletToLightSensor(MOTOR_A, -50, nxtT1, SENSOR_3, currentLight3, 4);

            
			%while j.Data(1) == 1
			%	pause(0.5)
            %    disp('mainline is busy')
			%end
			TransferArmRun(MOTOR_B, nxtT1, 105);
			pause(0.5);
			
			
    		TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, 16);
            b.Data(2) = b.Data(2) - 1;
			
            k=k+1;
		end
		
		if b.Data == 1
			disp('too many pallets on transfer line, waiting')
			pause(1);
	 	
        end
    
        disp(['transfer buffer = ', num2str(b.Data(2))]);
        disp(['feed buffer = ', num2str(b.Data(1))]);
        disp(['junction 1 = ', num2str(j.Data(1))]);
        pause(0.3)
    end
    pause(0.1);
end

clear j;
clear b;
CloseSensor(SENSOR_1, nxtT1);
CloseSensor(SENSOR_2, nxtT1);
CloseSensor(SENSOR_3, nxtT1);
COM_CloseNXT(nxtT1);