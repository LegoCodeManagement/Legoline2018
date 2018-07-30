function result = waitForPalletExit(nxt, port, ambientLight, timeOut,threshold)
%Should be invoked immediately after the light sensor detects a pallot

disp('waiting to detect pallet')

while -average(nxt,port)+ambientLight < threshold
    pause(0.2)
end

tic;
currentTime = toc;
pause(0.1)

disp('detected, waiting to exit')

while abs(average(nxt,port)-ambientLight) > threshold
    pause(0.1)
    if toc - currentTime > timeOut
        disp('The pallet hasnt left before time out');
        result = false;
        return;
    end
end


end
