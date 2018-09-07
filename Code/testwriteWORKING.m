config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
C1 = out{1};
C2 = out{2};
%format = '%s %s\n';
config2 = fopen('config2.txt','w');
for i=1:1:length(C1)
    line = [char(C1(i)),' ',char(C2(i))];
    fprintf(config2,'%s\r\n',line);
end
fclose(config2);