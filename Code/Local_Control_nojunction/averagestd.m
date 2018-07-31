function [meanstd,meanarray,stdarray,array] = averagestd(nxt,port,stdarray,array)

array = [array,GetLight(port, nxt)];
array(1) = [];
meanarray = mean(array);
stdarray = [stdarray,std(array)];
stdarray(1) = [];

meanstd = mean(stdarray);

end