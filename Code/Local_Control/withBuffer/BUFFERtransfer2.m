COM_CloseNXT('all');
nxtT1Addr = '0016530EE129';
nxtT1 = COM_OpenNXTEx('USB', nxtT1Addr);
OpenLight(SENSOR_3, 'ACTIVE', nxtT1);
OpenSwitch(SENSOR_2, nxtT1);
OpenLight(SENSOR_1, 'ACTIVE', nxtT1);

power = linepower;

TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, 16);
j2 = memmapfile('junction2.txt', 'Writable', true);
j3 = memmapfile('junction3.txt', 'Writable', true);
b2 = memmapfile('buffer2.txt', 'Writable', true, 'Format', 'int8');

currentLight1 = GetLight(SENSOR_1, nxtT1);
currentLight3 = GetLight(SENSOR_3, nxtT1);

disp('TRANSFER 2')
input('press ENTER to start')

clearPalletT2 = [timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);
                timer('TimerFcn', 'j2.Data(1) = j2.Data(1) - 1', 'StartDelay', 3.3);];

k=0;
while k < 5 %move 4 pallets onto mainline
    	
	if (abs(GetLight(SENSOR_1, nxtT1) - currentLight1) > 11)
    
		b1.Data(2) = b1.Data(2) + 1;
		movePalletToLightSensor(MOTOR_A, -power, nxtT1, SENSOR_3, currentLight3, 4);
		
		while j1.Data(1) == 1
			pause(0.25)
			disp('mainline is busy') %this clogs up console, need another method
		end
		
		TransferArmRun(MOTOR_B, nxtT1, 105);
		start(clearPalletT2(k))
		pause(0.6);
		TransferArmReset(MOTOR_B, SENSOR_2, nxtT1, 16);
		
		b1.Data(2) = b1.Data(2) - 1;
		
		k=k+1;
		
        disp(['transfer buffer = ', num2str(b1.Data(2))]);
        disp(['feed buffer = ', num2str(b1.Data(1))]);
        disp(['junction 1 = ', num2str(j1.Data(1))]);
        
    end
	pause(0.2);
end

disp('transfer 1 STOPPED')
delete(timerfind);
clear j1;
clear b1;
CloseSensor(SENSOR_1, nxtT1);
CloseSensor(SENSOR_2, nxtT1);
CloseSensor(SENSOR_3, nxtT1);
COM_CloseNXT(nxtT1);