disp('Running Splitter');
path2code = pwd;
path2code = path2code(1: length(path2code) - 13);
cd(path2code);

%% Collect information from configuration files
fileInit = memmapfile('InitializationStatus.txt', 'Writable', true, 'Format', 'int8');
fileInit.Data(12) = 49;
disp('Changed');
fileConfig = fopen('Configurations.txt', 'rt');
out = textscan(fileConfig, '%s %s');
fclose(fileConfig);
ind = strmatch('Splitter1', out{1}, 'exact');
nxtSAddr = char(out{2}(ind));
fileParam = fopen('Parameters.txt', 'rt');
out = textscan(fileParam, '%s %s');
fclose(fileParam);
ind = strmatch('ColourCode1', out{1}, 'exact');
colorCode = out{2}(ind); %Which type of pallet do we want to split

%% Open NXT and wait for the ready sign
nxtS = COM_OpenNXTEx('USB', nxtSAddr);
OpenColor(SENSOR_3, nxtS, 1);
OpenLight(SENSOR_2, 'ACTIVE', nxtS);
OpenSwitch(SENSOR_1, nxtS);
resetSplitterArm(nxtS, SENSOR_1, MOTOR_A, 3);
keepSplitterRunning = NXTMotor(MOTOR_B);
keepSplitterRunning.Power = 50; 
keepSplitterRunning.SpeedRegulation = 0;
fileInit.Data(12) = 50;

while fileInit.Data(1) == 48 %Wait for the ready sign
    pause(0.25);
end

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

%% Start the main loop
disp('Started!');
ambientLight2 = GetLight(SENSOR_2, nxtS);
cd([pwd filesep 'Local_Control']);%CRUCIAL
keepSplitterRunning.SendToNXT(nxtS);

for i=1:1:100
    if (fileInit.Data(1) == 53) %Needs to shutdown in this case according to the user
        break;
    end
    [result, color] = waitForPalletSplitter(nxtS, SENSOR_3, 5);
    if (fileInit.Data(1) == 53) %Needs to shutdown in this case according to the user
        break;
    end
    if strcmp(color, colorCode) == false
        pause(1);
        continue;
    end
    keepSplitterRunning.Stop('off', nxtS);
    keepSplitterRunning.TachoLimit = 100;
    keepSplitterRunning.ActionAtTachoLimit = 'Coast';
    keepSplitterRunning.SendToNXT(nxtS);
    keepSplitterRunning.WaitFor(2, nxtS);
    runSplitterArm(nxtS, MOTOR_A, 2);
    keepSplitterRunning.TachoLimit = 200;
    keepSplitterRunning.ActionAtTachoLimit = 'Coast';
    keepSplitterRunning.SendToNXT(nxtS);
    keepSplitterRunning.WaitFor(3, nxtS);
    resetSplitterArm(nxtS, SENSOR_1, MOTOR_A, 3);
    keepSplitterRunning = NXTMotor(MOTOR_B);
    keepSplitterRunning.Power = 50; 
    keepSplitterRunning.SpeedRegulation = 0;
    keepSplitterRunning.SendToNXT(nxtS);
end

%% Terminate this session
clear fileInit;
CloseSensor(SENSOR_1, nxtS);
CloseSensor(SENSOR_2, nxtS);
CloseSensor(SENSOR_3, nxtS);
keepSplitterRunning.Stop('off', nxtS);
COM_CloseNXT(nxtS);
quit;
