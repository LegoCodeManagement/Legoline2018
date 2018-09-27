clearvars j1 j2 j3 b1 b2 b3;

u= memmapfile('u.txt', 'Writable', true,'Format','int8');
m1 = memmapfile('m1.txt', 'Writable', true,'Format','int8');
m2 = memmapfile('m2.txt', 'Writable', true,'Format','int8');
b1 = memmapfile('buffer1.txt', 'Writable', true,'Format','int8');
b2 = memmapfile('buffer2.txt', 'Writable', true,'Format','int8');
b3 = memmapfile('buffer3.txt', 'Writable', true,'Format','int8');

b1.Data(1) = 48;
b1.Data(2) = 48;
b2.Data(1) = 48;
b2.Data(2) = 48;
b3.Data(1) = 48;
b3.Data(2) = 48;
u.Data(1) = 48;
m1.Data(1) = 48;
m2.Data(1) = 48;

disp('values have been reset');
