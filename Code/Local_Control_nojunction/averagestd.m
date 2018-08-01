function [meanstd,meanarray,stdarray,array] = averagestd(nxt,port,stdarray,array)

%input initial array stdarray = zeros(1,n) and array = ones(1,m) (n=7 and m=10 works best for pallets)
%repeatedly call this function to find the standard deviation and light data smoothed over n and m points respectively.
%smoothing helps to identify pallets.

array = [array,GetLight(port, nxt)];
array(1) = [];
meanarray = mean(array);
stdarray = [stdarray,std(array)];
stdarray(1) = [];

meanstd = mean(stdarray);

end