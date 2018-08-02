clearvars j1 j2 j3 b1 b2 b3;

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(1) = 48;
j1 = memmapfile('junction1.txt', 'Writable', true);
j2 = memmapfile('junction2.txt', 'Writable', true);
j3 = memmapfile('junction2.txt', 'Writable', true);
b1 = memmapfile('buffer1.txt', 'Writable', true);
b2 = memmapfile('buffer2.txt', 'Writable', true);
b3 = memmapfile('buffer2.txt', 'Writable', true);

b1.Data(1) = 0;
b1.Data(2) = 0;
b2.Data(1) = 0;
b2.Data(2) = 0;
b3.Data(1) = 0;
b3.Data(2) = 0;
j1.Data(1) = 0;
j2.Data(1) = 0;
j3.Data(1) = 0;

disp('values have been reset');
