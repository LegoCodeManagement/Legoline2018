%Yellow: Red Green both above 200
%Black: Everything below 35
%Grey belt: everything in between 35 - 50
%Red: Red above 150 but smaller than 170
%It cannot always differentiate black from grey.
function [result, color] = waitForPalletSplitter(nxt, port, timeOut)
tic;
currentTime = toc;
result = true;
while true
    if (toc - currentTime > timeOut)
        disp('The color sensor hasnt detected the pallet before timeout');
        color = 'Unknown';
        result = false;
        return;
    end
    [~, r g b] = GetColor(port, 0, nxt);
    if (g > 150)
        color = 'Yellow';
        [~, r g b] = GetColor(port, 0, nxt)
        return;
    elseif (r > 120)
        color = 'Red';
        [~, r g b] = GetColor(port, 0, nxt)
        return;
    elseif (b > 100)
        color = 'Blue';
        [~, r g b] = GetColor(port, 0, nxt)
        return;
    end
    pause(0.05);
end
end