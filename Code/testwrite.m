config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
C = [char(out{1}),char(out{2})];
format = '%s " " %s\n';
config2 = fopen('config2.txt','w');
for i=1:1:length(C)
    for j=1:1:length(C(1,:))
    fprintf(config2,'%c',C(i,j));
    end
    
end
fclose(config2);