clearvars j1 j2 j3 b1 b2 b3;

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(1) = 48;
j1 = memmapfile('junction1.txt', 'Writable', true,'Format','int8');
j2 = memmapfile('junction2.txt', 'Writable', true,'Format','int8');
j3 = memmapfile('junction2.txt', 'Writable', true,'Format','int8');
b1 = memmapfile('buffer1.txt', 'Writable', true,'Format','int8');
b2 = memmapfile('buffer2.txt', 'Writable', true,'Format','int8');
b3 = memmapfile('buffer2.txt', 'Writable', true,'Format','int8');

b1.Data(1) = 48;
b1.Data(2) = 48;
b2.Data(1) = 48;
b2.Data(2) = 48;
b3.Data(1) = 48;
b3.Data(2) = 48;
j1.Data(1) = 48;
j2.Data(1) = 48;
j3.Data(1) = 48;

disp('values have been reset');
