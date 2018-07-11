switch b.Data(2)

	case 0
	switch b.Data(1)
	
		case 0 
		feedPallet(nxtF1, SENSOR_1, MOTOR_A);
		b.Data(1) = b.Data(1) + 1;
		
		movePalletToLightSensor(MOTOR_B, 70, nxtF1, SENSOR_3, currentLight3, 3);
		
		b.Data(1) = b.Data(1) - 1;
		b.Data(2) = b.Data(2) + 1;
		
		case 1 
		movePalletToLightSensor(MOTOR_B, 70, nxtF1, SENSOR_3, currentLight3, 3);
		
		b.Data(1) = b.Data(1) - 1;
		b.Data(2) = b.Data(2) + 1;
	
		case 2
		movePalletToLightSensor(MOTOR_B, 70, nxtF1, SENSOR_3, currentLight3, 3);
		
		b.Data(1) = b.Data(1) - 1;
		b.Data(2) = b.Data(2) + 1;
	
	
		otherwise 
		disp('error, transfer buffer =')
		b.Data(2)
		
	end
		
	case 1
	switch b.Data(1)
		
		case 0 
		feedPallet(nxtF1, SENSOR_1, MOTOR_A);
		movePalletSpacing(1, MOTOR_B, 40, nxtF1);
		b.Data(1) = b.Data(1) + 1;
		
		case 1
		feedPallet(nxtF1, SENSOR_1, MOTOR_A);
		movePalletSpacing(1, MOTOR_B, 40, nxtF1);
		b.Data(1) = b.Data(1) + 1;
		
		otherwise
		pause(2);
		disp('waiting, too many pallets on feed line')
	

	otherwise
	disp('error, feed buffer =')
	b.Data(1)
	
end