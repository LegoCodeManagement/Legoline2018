COM_CloseNXT('all');
disp('Running Feed1');
nxtF1Addr = '00165308EE03';
nxtF1 = COM_OpenNXTEx('USB', nxtF1Addr);
OpenSwitch(SENSOR_1, nxtF1);
OpenLight(SENSOR_3, 'ACTIVE', nxtF1);

%{
filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
while m.Data(1) == 1
    pause(0.25);
end
clear m;
%}

b = memmapfile('buffer.txt', 'Writable', true, 'Format', 'int8');


currentLight3 = GetLight(SENSOR_3, nxtF1);

disp('feed')
input('press ENTER to start');
i=0;
while i<6
    disp(['feed buffer = ', num2str(b.Data(1))]);
    disp(['transfer buffer = ', num2str(b.Data(2))]);
	
	switch b.Data(2)

        case 0
            switch b.Data(1)
	
                case 0 
                    feedPallet(nxtF1, SENSOR_1, MOTOR_A);
                    b.Data(1) = b.Data(1) + 1;
                    movePalletToLightSensor(MOTOR_B, 50, nxtF1, SENSOR_3, currentLight3, 3);
                    i=i+1;
                    disp('00')
                case 1 
                    movePalletToLightSensor(MOTOR_B, 50, nxtF1, SENSOR_3, currentLight3, 3);
                    disp('01')
                case 2
                    movePalletToLightSensor(MOTOR_B, 50, nxtF1, SENSOR_3, currentLight3, 3);
                    pause(2);
                    movePalletSpacing(400, MOTOR_B, -50, nxtF1);
                    disp('02')
                otherwise 
                    disp('error, transfer buffer =')
                    b.Data(2)
                    disp('0 ow')
            end
	
        case 1
            switch b.Data(1)
		
                case 0 
                    feedPallet(nxtF1, SENSOR_1, MOTOR_A);
                    movePalletSpacing(130, MOTOR_B, 50, nxtF1);
                    b.Data(1) = b.Data(1) + 1;
                    i=i+1;
                    disp('10')
                case 1
                    movePalletSpacing(200, MOTOR_B, 50, nxtF1);
                    feedPallet(nxtF1, SENSOR_1, MOTOR_A);
                    movePalletSpacing(130, MOTOR_B, 50, nxtF1);
                    b.Data(1) = b.Data(1) + 1;
                    i=i+1;
                    disp('11')
                otherwise
                    pause(2);
                    disp('waiting, too many pallets on feed line')
                    disp('1 ow')
            end
    
        otherwise
            disp('error, feed buffer =')
            b.Data(1)
            disp('ow')
        
    end
	

    pause(1);
    
end

input('Press ENTER to stop');
CloseSensor(SENSOR_3, nxtF1);
CloseSensor(SENSOR_1, nxtF1);
clear b;
COM_CloseNXT('all');
