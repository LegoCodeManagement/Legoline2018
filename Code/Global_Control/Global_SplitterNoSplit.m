addpath RWTHMindstormsNXT;
global fstatus
%% Collect information from configuration files
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(12) = 49;



config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);

power 		= str2double(out{2}(strcmp('SPEED_S',out{1})));
nxtSAddr	= char(out{2}(strcmp('Splitter',out{1})));

%Which type of pallet do we want to split?

%% Open NXT and wait for the ready sign
nxtS = COM_OpenNXTEx('USB', nxtSAddr);
OpenColor(SENSOR_3, nxtS, 1);
OpenLight(SENSOR_2, 'ACTIVE', nxtS);
OpenSwitch(SENSOR_1, nxtS);
resetSplitterArm(nxtS, SENSOR_1, MOTOR_A, 3);

keepSplitterRunning = NXTMotor(MOTOR_B,'Power',power,'SpeedRegulation',0);

fstatus.Data(12) = 50;

while fstatus.Data(1) == 48 %Wait for the ready sign
    pause(0.5);
end

%{
if fileInit.Data(1) ~= 50
    %Needs to stop in this case either because the user chooses to shut
    %down or the configuration file is corrupted
    CloseSensor(SENSOR_1, nxtS);
    CloseSensor(SENSOR_2, nxtS);
    CloseSensor(SENSOR_3, nxtS);
    COM_CloseNXT(nxtS);
    if fileInit.Data(1) ~= 49
        disp('Error reading initialization data');
        pause(5);
    end
    clear fileInit;
    quit;
end
%}

%% Start the main loop
disp('Started!');
ambientLight2 = GetLight(SENSOR_2, nxtS);

keepSplitterRunning.SendToNXT(nxtS);

while fstatus.Data(1) == 49;
    pause(0.3);
end

%% Terminate this session
CloseSensor(SENSOR_1, nxtS);
CloseSensor(SENSOR_2, nxtS);
CloseSensor(SENSOR_3, nxtS);
keepSplitterRunning.Stop('off', nxtS);
COM_CloseNXT(nxtS);
