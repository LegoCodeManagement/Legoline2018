filename = 'Temp.txt';
%[f, msg] = fopen(filename, 'r+', 'n', 'US-ASCII');
%fwrite(f, '         ');
%fclose(f);
m = memmapfile(filename, 'Writable', true, 'Format', 'int8');
m.Data(1) = 1;
data = input('Please enter text:', 's');
m.Data(2:length(data)+1) = data;
m.Data(1) = length(data);
clear m;
quit