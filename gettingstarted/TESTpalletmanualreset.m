fileJunc1 = memmapfile('Junction1.txt','Writable',true);
fileJunc1.Data(1) = 49;
input('press ENTER to set pallets to zero')
fileJunc1.Data(1) = 48;