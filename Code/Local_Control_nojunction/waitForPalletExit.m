function result = waitForPalletExit(nxt, port, ambientLight, timeOut,threshold)
%Should be invoked immediately after the light sensor detects a pallot


if abs(average(nxt,port)-ambientLight) > threshold
	pause(0.1)
tic;
currentTime = toc

	while abs(average(nxt,port)-ambientLight) > threshold
		pause(0.05)
		if toc - currentTime > timeOut
			disp('The pallet hasnt left before time out');
			result = false;
			return;
    	end
	end
	
	pause(0.1)
end

end