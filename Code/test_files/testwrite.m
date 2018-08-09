x = 0:.1:1;
A = [x; exp(x)];

fileID = fopen('exp3.txt','w');
fprintf(fileID,'%f %f\n',A);
fclose(fileID);