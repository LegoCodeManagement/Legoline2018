%initialise buffer file

b = memmapfile('buffer.txt', 'Writable', true, 'Format', 'int8');
input('press ENTER to reset buffer.txt')
b.Data(1) = 0;
b.Data(2) = 0;

b.Data(1)
b.Data(2)