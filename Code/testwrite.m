config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
row = find(strcmp('Main1',out{1}));
out{2}{row} = sprintf('%s','test');
C = [string(out{1}), string(out{2})];
format = '%s %s\n';
config2 = fopen('config2.txt','w');
for i=1:1:length(C)
    fprintf(config2,format,C(i,:));
end