function result = movePalletPastLightSensor(motor, power, nxt, port, timeOut, threshold)

movePallet = NXTMotor(motor, 'Power', power);
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);
global wait

array = ones(1,10)*GetLight(port,nxt);
stdarray = zeros(1,7)
stdavg = mean(stdarray)

tic;

while stdavg < threshold

    if wait.Data(1) == 49
		movePallet.Stop('off',nxt);
		while wait.Data(1) == 49
			pause(0.2);
		end
		movePallet.SendToNXT(nxt);
	end
    
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.02)
    
    %checkTimeOut(timeOut)
    
end

tic;

while stdavg > threshold*0.5
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.02)
    
    %checkTimeOut(timeOut)
    
end

movePallet.Stop('off', nxt);
end