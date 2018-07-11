function result = waitForPalletExit(nxt, port, ambientLight, timeOut)
%Should be invoked immediately after the light sensor detects a pallot
deviation = ones(1,5) * abs(GetLight(port, nxt) - ambientLight);
averageDeviation = deviation(1);
tic;
result = true;
currentTime = toc;
while averageDeviation > 5
    if toc - currentTime > timeOut
        disp('The pallet hasnt left before time out');
        result = false;
        return;
    end
    deviation(1) = deviation(2);
    deviation(2) = deviation(3);
    deviation(3) = deviation(4);
    deviation(4) = deviation(5);
    deviation(5) = abs(GetLight(port, nxt) - ambientLight);
    averageDeviation = 0.2 * (deviation(1) + deviation(2) + deviation(3) + deviation(4) + deviation(5));
    pause(0.02);
end
end
