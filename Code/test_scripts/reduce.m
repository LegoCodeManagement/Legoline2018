function result = reduce(array)
A = [];
for i=1:1:length(array)
    if array(i) ~= 48
        A = [A,array(i)];
    end
end
result = A;
end