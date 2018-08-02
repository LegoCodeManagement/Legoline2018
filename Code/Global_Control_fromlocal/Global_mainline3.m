addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(9) = 49;
wait = memmapfile('wait.txt', 'Writable', true);

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

%retrieve parameters
power = str2double(out{2}(strcmp('SPEED_M',out{1})));
M3addr = char(out{2}(strcmp('Main3',out{1})));
%open connection and activate sensors
nxtM3 = COM_OpenNXTEx('USB', Uaddr);
OpenLight(SENSOR_1, 'ACTIVE', nxtM3);
OpenLight(SENSOR_2, 'ACTIVE', nxtM3);


mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);
fstatus.Data(9) = 50;
disp('MAINLINE 3');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.1);
end

mainline.SendToNXT(nxtM3);

while fstatus.Data(1) == 49
	pause(0.25);
end

mainline.Stop('off', nxtM3);
disp('Main 3 STOPPED');
CloseSensor(SENSOR_1, nxtM3);
CloseSensor(SENSOR_2, nxtM3);
COM_CloseNXT(nxtM3);

