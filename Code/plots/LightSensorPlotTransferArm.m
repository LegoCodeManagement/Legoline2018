%Plot the value of light sensor against time when the pallet passes through
%Notice that when two lights shine at each other their reading is different
%Now I am using the difference > 10 method. If this method does not work
%I will go back to setting thresholds for light sensors
addpath RWTHMindstormsNXT;
figure;

T1addr = '0016530AABDF';

nxtT1 = COM_OpenNXTEx('USB', T1addr);

OpenLight(SENSOR_3, 'ACTIVE', nxtT1);

movePalletT = NXTMotor(MOTOR_A);
movePalletT.Power = -40; 
movePalletT.SpeedRegulation = 0;

x=linspace(0,4,100);
z=zeros(1, 100);
movePalletT.SendToNXT(nxtT1);
for i=1:1:100
    z(i)=GetLight(SENSOR_3, nxtT1);
    pause(0.03);
end

movePalletT.Stop('off', nxtT1);
plot(x,z)
CloseSensor(SENSOR_3, nxtT1);
COM_CloseNXT('all');