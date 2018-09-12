config = fopen('Parameters.txt','rt');
out = textscan(config, '%s %s %s %s %s');
fclose(config);
row = find(strcmp('ControlUpstr',out{1}));
dist    = char(out{2}(row));
param1  = str2double(out{3}(row));
param2  = str2double(out{4}(row));
param3  = str2double(out{5}(row));

switch dist
    case 'E'
        disp('yes')
    case 'R'
        disp('no')
end