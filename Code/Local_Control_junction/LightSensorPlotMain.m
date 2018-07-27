%Plot the value of light sensor against time when the pallet passes through
%Notice that when two lights shine at each other their reading is different
%Now I am using the difference > 10 method. If this method does not work
%I will go back to setting thresholds for light sensors
figure;
nxtMain1Addr = '0016530EE594';
nxtMain1 = COM_OpenNXTEx('USB', nxtMain1Addr);
nxtMain2Addr = '001653118AC9';
nxtMain2 = COM_OpenNXTEx('USB', nxtMain2Addr);
OpenLight(SENSOR_1, 'ACTIVE', nxtMain2);
OpenLight(SENSOR_2, 'ACTIVE', nxtMain1);
movePallet = NXTMotor(MOTOR_A);
movePallet.Power = -50; 
movePallet.SpeedRegulation = 0;
x=linspace(0,4,100);    
y=zeros(1, 100);
z=zeros(1, 100);
movePallet.SendToNXT(nxtMain1);
movePallet.SendToNXT(nxtMain2);
for i=1:1:100
    y(i)=GetLight(SENSOR_2, nxtMain1);
    z(i)=GetLight(SENSOR_1, nxtMain2);
    pause(0.04);
end
movePallet.Stop('brake', nxtMain1);
movePallet.Stop('brake', nxtMain2);
plot(x,y)
%plot(x,z)
CloseSensor(SENSOR_1, nxtMain2);
CloseSensor(SENSOR_2, nxtMain1);
COM_CloseNXT('all');