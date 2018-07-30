function result = waitForPalletExit(nxt, port, ambientLight, timeOut,threshold)
%Should be invoked immediately after the light sensor detects a pallot

disp('waiting to detect pallet')

array = ones(1,10)*GetLight(port,nxt);
avg = mean(array);
while ambientLight-avg < threshold
	[avg,array] = average(nxt,port,array);
    pause(0.1)
end

tic;
currentTime = toc;
pause(0.1)

disp('detected, waiting to exit')
while abs(avg-ambientLight) > threshold
	[avg,array] = average(nxt,port,array);
    pause(0.1)
    if toc - currentTime > timeOut
        disp('The pallet hasnt left before time out');
        result = false;
        return;
    end
end


end
