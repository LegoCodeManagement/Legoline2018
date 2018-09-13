addpath RWTHMindstormsNXT;
global fstatus
%% Collect information from configuration files
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(12) = 49;

cd ../
config  = fopen('config.txt','rt');
cd([pwd,filesep,'Local_Control']);
out 	= textscan(config, '%s %s');
fclose(config);
power       = str2double(out{2}(strcmp('line_speed',out{1})));
nxtSAddr	= char(out{2}(strcmp('Splitter',out{1})));

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

%% Start the main loop
disp('Started!');
ambientLight2 = GetLight(SENSOR_2, nxtS);

keepSplitterRunning.SendToNXT(nxtS);

while fstatus.Data(1) == 49
    [result, color] = waitForPalletSplitter(nxtS, SENSOR_3, 20);
    %{
    if strcmp(color, colorCode) == false
        pause(1);
        continue;
    end
    %}
    disp(color);
    keepSplitterRunning.Stop('off', nxtS);
    keepSplitterRunning.TachoLimit = 100;
    keepSplitterRunning.ActionAtTachoLimit = 'Coast';
    keepSplitterRunning.SendToNXT(nxtS);
    keepSplitterRunning.WaitFor(2, nxtS);
    runSplitterArm(nxtS, MOTOR_A, 2);
    keepSplitterRunning.TachoLimit = 450;
    keepSplitterRunning.ActionAtTachoLimit = 'Coast';
    keepSplitterRunning.SendToNXT(nxtS);
    keepSplitterRunning.WaitFor(3, nxtS);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%need some delay here
    resetSplitterArm(nxtS, SENSOR_1, MOTOR_A, 3);
    keepSplitterRunning = NXTMotor(MOTOR_B,'Power',power,'SpeedRegulation',false);
    keepSplitterRunning.SendToNXT(nxtS);
    pause(0.1)
end

%% Terminate this session
CloseSensor(SENSOR_1, nxtS);
CloseSensor(SENSOR_2, nxtS);
CloseSensor(SENSOR_3, nxtS);
keepSplitterRunning.Stop('off', nxtS);
COM_CloseNXT(nxtS);
quit