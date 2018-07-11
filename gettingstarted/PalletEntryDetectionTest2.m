%Use the average value of the last five reading to detect the pallet.
%It is usuually 0.5 to 1 cm slower.
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
deviation2 = zeros(1,5); %5 is the newest deviation
averageDeviation2 = 0;
while averageDeviation2 < 11
    deviation2(1) = deviation2(2);
    deviation2(2) = deviation2(3);
    deviation2(3) = deviation2(4);
    deviation2(4) = deviation2(5);
    deviation2(5) = abs(GetLight(SENSOR_2, nxtMain1) - ambientLight2);
    averageDeviation2 = 0.2 * (deviation2(1) + deviation2(2) + deviation2(3) + deviation2(4) + deviation2(5));
    pause(0.02);
end

movePallet.Stop('brake', nxtMain1);
movePallet.Stop('brake', nxtMain2);
CloseSensor(SENSOR_1, nxtMain2);
CloseSensor(SENSOR_2, nxtMain1);
COM_CloseNXT('all');