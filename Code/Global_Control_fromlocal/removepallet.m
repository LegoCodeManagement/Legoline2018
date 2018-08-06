function result = removepallet(filename)
m1 = memmapfile(filename, 'Writable', true);

for i = 1:1:4
    
    m1.Data(i) = m1.Data(i+1);
    
end

end