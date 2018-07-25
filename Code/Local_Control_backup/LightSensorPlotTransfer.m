%Plot the value of light sensor against time when the pallet passes through
%Notice that when two lights shine at each other their reading is different
%Now I am using the difference > 10 method. If this method does not work
%I will go back to setting thresholds for light sensors

F1addr = '00165308EE03';
T1addr = '0016530AABDF';

nxtF1 = COM_OpenNXTEx('USB', F1addr);
nxtT1 = COM_OpenNXTEx('USB', T1addr);

OpenLight(SENSOR_3, 'ACTIVE', nxtF1);
OpenLight(SENSOR_1, 'ACTIVE', nxtT1);

movePalletF = NXTMotor(MOTOR_B);
movePalletF.Power = 40; 
movePalletF.SpeedRegulation = 0;

movePalletT = NXTMotor(MOTOR_A);
movePalletT.Power = -40; 
movePalletT.SpeedRegulation = 0;

x=linspace(0,4,100);    
y1=zeros(1, 100);
y2=zeros(1, 100);
movePalletF.SendToNXT(nxtF1);
movePalletT.SendToNXT(nxtT1);
for i=1:1:100
    y1(i)=GetLight(SENSOR_3, nxtF1);
    y2(i)=GetLight(SENSOR_1, nxtT1);
    pause(0.04);
end
movePalletF.Stop('off', nxtF1);
movePalletT.Stop('off', nxtT1);
figure
plot(x,y1,x,y2)
legend('feed','transfer')
CloseSensor(SENSOR_1, nxtT1);
CloseSensor(SENSOR_3, nxtF1);
COM_CloseNXT('all');