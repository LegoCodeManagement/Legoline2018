function result = movePalletPastLightSensor(motor, power, nxt, port, currentValue, timeOut, threshold)
%movePalletToLightSensor(motor, power, nxt, port, currentValue)
%Move the pallet until the light sensor detects it
%Return true if the function is completed within timeOut false otherwise
tic;
currentTime = toc;
movePallet = NXTMotor(motor, 'Power', power);
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);

waitForPalletExit(nxt, port, currentValue, timeOut, threshold);

movePallet.Stop('off', nxt);
end