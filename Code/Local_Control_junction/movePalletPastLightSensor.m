function result = movePalletPastLightSensor(motor, power, nxt, port, currentValue, timeOut, threshold)
%movePalletToLightSensor(motor, power, nxt, port, currentValue)
%Move the pallet until the light sensor detects it
%Return true if the function is completed within timeOut false otherwise
tic;
currentTime = toc;
movePallet = NXTMotor(motor, 'Power', power);
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);
pause(1);

waitForPalletExit(nxt, port, ambientLight, timeOut, threshold);

pause(0.1);
movePallet.Stop('off', nxt);
end