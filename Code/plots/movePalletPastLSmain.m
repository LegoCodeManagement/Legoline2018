function result = movePalletPastLightSensor(motor, power, nxt, port, timeOut, threshold)

movePallet = NXTMotor(motor, 'Power', power);
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);

array = ones(1,10)*GetLight(port,nxt);
stdarray = zeros(1,7)
stdavg = mean(stdarray)

tic;

while stdavg < threshold
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.1)
    
    checkTimeOut(timeOut)
    
end

tic;

while stdavg > threshold*0.5
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.1)
    
    checkTimeOut(timeOut)
    
end

pause(0.3);
movePallet.Stop('off', nxt);
end