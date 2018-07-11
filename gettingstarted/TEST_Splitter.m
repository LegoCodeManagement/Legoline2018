COM_CloseNXT('all');
nxtSAddr = '001653132A78';
disp('Running Splitter continuously');
nxtS = COM_OpenNXTEx('USB', nxtSAddr);
OpenColor(SENSOR_3, nxtS, 1);
OpenLight(SENSOR_2, 'ACTIVE', nxtS);
OpenSwitch(SENSOR_1, nxtS);
keepSplitterRunning = NXTMotor(MOTOR_B);
keepSplitterRunning.Power = 50; 
keepSplitterRunning.SpeedRegulation = 0;
resetSplitterArm(nxtS, SENSOR_1, MOTOR_A, 3);
ambientLight2 = GetLight(SENSOR_2, nxtS);

currentTime = toc;
while abs(GetLight(SENSOR_2, nxtS) - ambientLight2) < 11
    if (toc - currentTime > 6000)
        CloseSensor(SENSOR_1, nxtS);
        CloseSensor(SENSOR_2, nxtS);
        CloseSensor(SENSOR_3, nxtS);
        COM_CloseNXT(nxtS);
        disp('Please place a pallet before timeout');
        return;
    end
    pause(0.05);
end
keepSplitterRunning.SendToNXT(nxtS);
[result, color] = waitForPalletSplitter(nxtS, SENSOR_3, 5);
if strcmp(color, 'Red')
keepSplitterRunning.Stop('off', nxtS);
keepSplitterRunning.TachoLimit = 100;
keepSplitterRunning.ActionAtTachoLimit = 'Coast';
keepSplitterRunning.SendToNXT(nxtS);
keepSplitterRunning.WaitFor(2, nxtS);
runSplitterArm(nxtS, MOTOR_A, 2);
keepSplitterRunning.TachoLimit = 150;
keepSplitterRunning.ActionAtTachoLimit = 'Coast';
keepSplitterRunning.SendToNXT(nxtS);
keepSplitterRunning.WaitFor(2, nxtS);
resetSplitterArm(nxtS, SENSOR_1, MOTOR_A, 3);
end
keepSplitterRunning.Stop('off', nxtS);
CloseSensor(SENSOR_1, nxtS);
CloseSensor(SENSOR_2, nxtS);
CloseSensor(SENSOR_3, nxtS);
COM_CloseNXT(nxtS);