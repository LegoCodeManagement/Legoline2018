function result = movePalletPastLightSensor(motor, power, nxt, port, currentValue, timeOut, threshold)

tic;
currentTime = toc;
movePallet = NXTMotor(motor, 'Power', power);
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);

waitForDetectionExit(nxt, port, currentValue, timeOut, threshold);

movePallet.Stop('off', nxt);
end