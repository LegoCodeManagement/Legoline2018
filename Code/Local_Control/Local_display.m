fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
j1 = memmapfile('junction1.txt', 'Writable', true,'Format','int8');
j2 = memmapfile('junction2.txt', 'Writable', true,'Format','int8');
j3 = memmapfile('junction3.txt', 'Writable', true,'Format','int8')
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
    disp(['Feed line: ', num2str(b1.Data(1)-48)]);
    disp(['Transfer line: ', num2str(b1.Data(2)-48)]);
	disp(['Pallets on right half of Main 1 and Upstream: ', num2str(j1.Data(1)-48)]);
    disp(['Pallets on Main 2 and left half of Main 1: ', num2str(j2.Data(1)-48)]);
    disp(['Pallets on Main 3: ', num2str(j3.Data(1)-48)]);
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