nxtM1Addr = '0016530EE594';
disp('Running Main1');
nxtM1 = COM_OpenNXTEx('USB', nxtM1Addr);
OpenLight(SENSOR_1, 'ACTIVE', nxtM1);
OpenLight(SENSOR_2, 'ACTIVE', nxtM1);
currentLight1 = GetLight(SENSOR_1, nxtM1);
currentLight2 = GetLight(SENSOR_2, nxtM1);
keepMainlineRunning = NXTMotor(MOTOR_A);
keepMainLineRunning.SpeedRegulation = false;
keepMainlineRunning.Power = -40;
input('Press ENTER to start mainline');
keepMainlineRunning.SendToNXT(nxtM1);
input('Press ENTER to stop mainline');
%{
for i = 1:10
    while (abs(GetLight(SENSOR_1, nxtM1) - currentLight1) < 11)
    end
    disp('Moving pallet');
    movePalletToLightSensor(MOTOR_A, -70, nxtM1, SENSOR_2, currentLight2, 4);
end
clear m;
%}
keepMainlineRunning.Stop('off', nxtM1);
CloseSensor(SENSOR_1, nxtM1);
CloseSensor(SENSOR_2, nxtM1);
COM_CloseNXT(nxtM1);
quit