function result = waitForDetectionExit(nxt, port, timeOut,threshold)

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

end
