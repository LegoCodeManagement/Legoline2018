%Plot the value of light sensor against time when the pallet passes through
%Notice that when two lights shine at each other their reading is different
%Now I am using the difference > 10 method. If this method does not work
%I will go back to setting thresholds for light sensors

M1addr = '0016530EE594';
nxtM1 = COM_OpenNXTEx('USB', M1addr);
Uaddr = '0016530EE120';
nxtU = COM_OpenNXTEx('USB', Uaddr);
OpenLight(SENSOR_2, 'ACTIVE', nxtU);
OpenLight(SENSOR_1, 'ACTIVE', nxtM1);

movePalletM = NXTMotor(MOTOR_A);
movePalletM.Power = -40; 
movePalletM.SpeedRegulation = 0;

movePalletU = NXTMotor(MOTOR_B);
movePalletU.Power = 40; 
movePalletU.SpeedRegulation = 0;

x=linspace(0,4,300);    
y1=zeros(1, 300);
y2=zeros(1, 300);
y3=zeros(1, 300);
y4=zeros(1, 300);

movePalletM.SendToNXT(nxtM1);
movePalletU.SendToNXT(nxtU);
array1 = ones(1,10)*GetLight(SENSOR_1, nxtM1);
array2 = ones(1,10)*GetLight(SENSOR_2, nxtU);
stdarray1 = zeros(1,7);
stdarray2 = zeros(1,7);
for i=1:1:300
    [y1(i),y3(i),stdarray1,array1] = averagestd(nxtM1,SENSOR_1,stdarray1,array1);
    [y2(i),y4(i),stdarray2,array2] = averagestd(nxtU,SENSOR_2,stdarray2,array2);
    pause(0.04);
end
movePalletM.Stop('off', nxtM1);
movePalletU.Stop('off', nxtU);

figure
plot(x,y1,x,y2)
legend('main','upstream')

figure
plot(x,y3,x,y4)
legend('main','upstream')

CloseSensor(SENSOR_2, nxtU);
CloseSensor(SENSOR_1, nxtM1);
COM_CloseNXT('all');