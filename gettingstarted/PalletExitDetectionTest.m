nxtMain1Addr = '0016530EE594';
nxtMain1 = COM_OpenNXTEx('USB', nxtMain1Addr);
nxtMain2Addr = '001653118AC9';
nxtMain2 = COM_OpenNXTEx('USB', nxtMain2Addr);
OpenLight(SENSOR_1, 'ACTIVE', nxtMain2);
OpenLight(SENSOR_2, 'ACTIVE', nxtMain1);
movePallet = NXTMotor(MOTOR_A);
movePallet.Power = -50; 
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxtMain1);
movePallet.SendToNXT(nxtMain2);
pause(1);
ambientLight2 = GetLight(SENSOR_2, nxtMain1);

%% Wait for pallet to reach the light sensor
while abs(GetLight(SENSOR_2, nxtMain1) - ambientLight2) < 11
    pause(0.1);
end

%{
deviation = ones(1,5) * abs(GetLight(SENSOR_2, nxtMain1) - ambientLight2);
averageDeviation = ones(1, 200)*deviation(1);

for j = 1:200
    deviation(1) = deviation(2);
    deviation(2) = deviation(3);
    deviation(3) = deviation(4);
    deviation(4) = deviation(5);
    deviation(5) = abs(GetLight(SENSOR_2, nxtMain1) - ambientLight2);
    averageDeviation(j) = 0.2 * (deviation(1) + deviation(2) + deviation(3) + deviation(4) + deviation(5));
    pause(0.02);
end

x = linspace(0, 4, 200);
figure;
plot(x, averageDeviation);
%}


%%Terminate this session
movePallet.Stop('brake', nxtMain1);
movePallet.Stop('brake', nxtMain2);
CloseSensor(SENSOR_1, nxtMain2);
CloseSensor(SENSOR_2, nxtMain1);
COM_CloseNXT('all');