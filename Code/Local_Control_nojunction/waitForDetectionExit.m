function result = waitForDetectionExit(nxt, port, ambientLight, timeOut,threshold)

array = ones(1,10)*GetLight(port,nxt);
stdarray = zeros(1,7)
stdavg = mean(stdarray)
while stdavg < threshold
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.1)
end

tic;

while stdavg > threshold*0.5
	[stdavg,avg,stdarray,array] = averagestd(nxt,port,stdarray,array);
    pause(0.1)
    
    if toc > timeOut
        disp('The pallet hasnt left before time out');
        result = false;
        return;
    end
    
end


end
