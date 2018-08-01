function result = movePalletPastLightSensor(motor, power, nxt, port, currentValue, timeOut, threshold)

tic;
currentTime = toc;
movePallet = NXTMotor(motor, 'Power', power);
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);

waitForDetectionExitFT(nxt, port, currentValue, timeOut, threshold);

pause(0.3);
movePallet.Stop('off', nxt);
end