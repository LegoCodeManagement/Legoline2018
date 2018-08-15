function result = removepallet(filename)
m1 = memmapfile(filename, 'Writable', true);

if m1.Data(1) == 48
	result = false;
	disp('error');
	return;
end

for i = 1:1:4
    
    m1.Data(i) = m1.Data(i+1);
 
end
result = true;
return;
end