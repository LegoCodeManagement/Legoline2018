config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
C = [string(out{1}),string(out{2})];
format = '%s %s\n';
config2 = fopen('config2.txt','w');
for i=1:1:length(C)
    fprintf(config2,format,C(i,:));
end
fclose(config2);