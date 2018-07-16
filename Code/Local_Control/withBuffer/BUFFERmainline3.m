addpath RWTHMindstormsNXT;

COM_CloseNXT('all')

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
power = str2double(out{2}(strcmp('SPEED_M',out{1})));
M3addr = char(out{2}(strcmp('Main3',out{1})));

nxtM3 = COM_OpenNXTEx('USB', Uaddr);

OpenLight(SENSOR_1, 'ACTIVE', nxtM3);
OpenLight(SENSOR_2, 'ACTIVE', nxtM3);





mainline = NXTMotor(MOTOR_A,'Power',-power,'SpeedRegulation',false);

disp('MAINLINE 3')
input('Press ENTER to start')

mainline.SendToNXT(M3);

while fstatus.Data(1) == 49
	pause(0.25);
end

mainline.Stop('off', nxtM3);
disp('Main 3 STOPPED');
CloseSensor(SENSOR_1, nxtM3);
CloseSensor(SENSOR_2, nxtM3);
COM_CloseNXT(nxtM3);

