function result = waitForDetectionExit(nxt, port, ambientLight, timeOut,threshold)

array = ones(1,10)*GetLight(port,nxt);
stdarray = zeros(1,7)
stdavg = mean(stdarray)
while stdavg < threshold
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.02)
end

tic;

while stdavg > threshold*0.9
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.02)
end

while stdavg < threshold
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.02)
end

pause(0.1)

end
