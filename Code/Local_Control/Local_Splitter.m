addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(12) = 49;

%open config file and save variable names and values column 1 and 2
%respectively.
cd ../
config = fopen('config.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(config, '%s %s');
fclose(config);

%retrieve parameters
power = str2double(out{2}(strcmp('line_speed',out{1})));
Saddr = char(out{2}(strcmp('Splitter1',out{1})));
%open connection and activate sensors
nxtS = COM_OpenNXTEx('USB', Saddr);
OpenLight(SENSOR_1, 'ACTIVE', nxtS);
OpenLight(SENSOR_2, 'ACTIVE', nxtS);


mainline = NXTMotor(MOTOR_B,'Power',power,'SpeedRegulation',false);
fstatus.Data(12) = 50;
disp('SPLITTER');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.1);
end

mainline.SendToNXT(nxtS);

while fstatus.Data(1) == 49
	pause(0.25);
end

mainline.Stop('off', nxtS);
disp('Splitter STOPPED');
CloseSensor(SENSOR_1, nxtS);
CloseSensor(SENSOR_2, nxtS);
COM_CloseNXT(nxtS);
quit;
