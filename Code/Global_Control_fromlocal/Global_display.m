fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
u1 = memmapfile('count_u1.txt', 'Writable', true,'Format','int8');
m1 = memmapfile('count_m1.txt', 'Writable', true,'Format','int8');
m2 = memmapfile('count_m2.txt', 'Writable', true,'Format','int8')
b1 = memmapfile('buffer1.txt', 'Writable', true,'Format','int8');
b2 = memmapfile('buffer2.txt', 'Writable', true,'Format','int8');
b3 = memmapfile('buffer3.txt', 'Writable', true,'Format','int8');

while fstatus.Data(1) == 48
    pause(0.5);
    clc
    disp('waiting')
end
%i=0;
while (fstatus.Data(1) == 49)
    disp(['Pallets on Buffer 1: ', num2str(transpose(b1.Data-48))]);
	disp(['Pallets on Upstream: ', num2str(transpose(u1.Data-48))]);
    disp(['Pallets on Main 1: ', num2str(transpose(m1.Data-48))]);
    disp(['Pallets on Main 2: ', num2str(transpose(m2.Data-48))]);
	pause(0.1)
	clc
	%i=i+1;
	%{
	if (i == 5)
		clc
		i = 0;
	end
	%}
end

quit