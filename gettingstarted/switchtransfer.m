while i<2

		
	if (abs(GetLight(SENSOR_1, nxtT1) - currentLight1) > 20) && (m.Data(2) == 0)
			movePalletToLightSensor(MOTOR_A, -60, nxtT1, SENSOR_3, currentLight3, 4);
		
		while j.Data(1) == 1
			pause(0.5)
		end
		
		runTransferArm(MOTOR_B, nxtT1, 105);
		pause(1);
    	resetTransferArm(MOTOR_B, SENSOR_2, nxtT1, 16);
		i=i+1


	pause(1)