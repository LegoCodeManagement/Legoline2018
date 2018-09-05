x = 0:.1:1;
A = [x; exp(x)];

fileID = fopen('data.txt','w');
fprintf(fileID,'%f %f\n',A);
fclose(fileID);