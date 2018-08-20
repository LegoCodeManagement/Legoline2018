function write(filename,A)

ID = fopen(filename,'w');
fprintf(ID,'%f %f %f %f %f %f %f %f\n',A);
fclose(ID);

end