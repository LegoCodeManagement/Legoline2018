function [avg,array] = averagetest(array)

array = [array,1];
array(1) = [];

avg = mean(array);
array = array;
end