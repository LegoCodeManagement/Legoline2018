filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
while m.Data(1) == 1
    pause(0.25);
end
fprintf('%s\n', m.Data(2:m.Data(1)+1));
clear m;