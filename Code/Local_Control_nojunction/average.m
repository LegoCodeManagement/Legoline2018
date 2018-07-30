function [avg,newarray] = average(nxt,port,array)

array = [array,GetLight(port, nxt)];
array(1) = [];

avg = mean(array);
newarray = array;
end