function result = movePalletPastLightSensor(motor, power, nxt, port, timeOut, threshold)

tic;
currentTime = toc;
movePallet = NXTMotor(motor, 'Power', power);
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);

array = ones(1,10)*GetLight(port,nxt);
stdarray = zeros(1,7)
stdavg = mean(stdarray)

while stdavg < threshold
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.02)
    checkTimeOut(timeOut)
end

while stdavg > threshold*0.9
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.02)
    checkTimeOut(timeOut)
end

while stdavg < threshold
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.02)
    checkTimeOut(timeOut)
end

pause(0.1)

pause(0.3);
movePallet.Stop('off', nxt);
end