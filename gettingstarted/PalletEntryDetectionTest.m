COM_CloseNXT('all');
nxtMain1Addr = '0016530EE594';
nxtMain1 = COM_OpenNXTEx('USB', nxtMain1Addr);
nxtMain2Addr = '001653118AC9';
nxtMain2 = COM_OpenNXTEx('USB', nxtMain2Addr);
OpenLight(SENSOR_2, 'ACTIVE', nxtMain1);
OpenLight(SENSOR_1, 'ACTIVE', nxtMain2);
movePallet = NXTMotor(MOTOR_A);
movePallet.Power = -50; 
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxtMain1);
movePallet.SendToNXT(nxtMain2);
ambientLight2 = GetLight(SENSOR_2, nxtMain1);
%This method proves to be very reliable now
while abs(GetLight(SENSOR_2, nxtMain1) - ambientLight2) < 11
    pause(0.02);
end
movePallet.Stop('brake', nxtMain1);
movePallet.Stop('brake', nxtMain2);
CloseSensor(SENSOR_1, nxtMain2);
CloseSensor(SENSOR_2, nxtMain1);
COM_CloseNXT('all');