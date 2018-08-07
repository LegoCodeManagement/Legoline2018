%Plot the value of light sensor against time when the pallet passes through
%Notice that when two lights shine at each other their reading is different
%Now I am using the difference > 10 method. If this method does not work
%I will go back to setting thresholds for light sensors

Uaddr = '0016530EE120';
nxtU = COM_OpenNXTEx('USB', Uaddr);
nxtM1Addr = '0016530EE594';
nxtM1 = COM_OpenNXTEx('USB', nxtM1Addr);
nxtM2Addr = '001653118AC9';
nxtM2 = COM_OpenNXTEx('USB', nxtM2Addr);
nxtM3Addr = '001653118B91';
nxtM3 = COM_OpenNXTEx('USB', nxtM3Addr);
nxtSAddr = '001653132A78';
nxtS = COM_OpenNXTEx('USB', nxtSAddr);

OpenLight(SENSOR_2, 'ACTIVE', nxtU);
OpenLight(SENSOR_1, 'ACTIVE', nxtM1);
OpenLight(SENSOR_1, 'ACTIVE', nxtM2);
OpenLight(SENSOR_1, 'ACTIVE', nxtM3);
OpenLight(SENSOR_2, 'ACTIVE', nxtM1);
OpenLight(SENSOR_2, 'ACTIVE', nxtM2);
OpenLight(SENSOR_2, 'ACTIVE', nxtM3);

movePalletM = NXTMotor(MOTOR_A);
movePalletM.Power = -40; 
movePalletM.SpeedRegulation = 0;

movePalletU = NXTMotor(MOTOR_B);
movePalletU.Power = 35; 
movePalletU.SpeedRegulation = 0;

n=500;

x=linspace(0,5,n);    
y1  = zeros(1, n); stdarray1 = zeros(1,7);
y2  = zeros(1, n); stdarray2 = zeros(1,7);
y3  = zeros(1, n); stdarray3 = zeros(1,7);
y4  = zeros(1, n); stdarray4 = zeros(1,7); 
y5  = zeros(1, n); stdarray5 = zeros(1,7);
y6  = zeros(1, n); stdarray6 = zeros(1,7); 
y7  = zeros(1, n); stdarray7 = zeros(1,7);
y8  = zeros(1, n); array1 = ones(1,10)*GetLight(SENSOR_2, nxtU);
y9  = zeros(1, n); array2 = ones(1,10)*GetLight(SENSOR_1, nxtM1);
y10 = zeros(1, n); array3 = ones(1,10)*GetLight(SENSOR_2, nxtM1);
y11 = zeros(1, n); array4 = ones(1,10)*GetLight(SENSOR_1, nxtM2);
y12 = zeros(1, n); array5 = ones(1,10)*GetLight(SENSOR_2, nxtM2);
y13 = zeros(1, n); array6 = ones(1,10)*GetLight(SENSOR_1, nxtM3);
y14 = zeros(1, n); array7 = ones(1,10)*GetLight(SENSOR_2, nxtM3);
movePalletU.SendToNXT(nxtU);
movePalletU.SendToNXT(nxtS);
movePalletM.SendToNXT(nxtM1);
movePalletM.SendToNXT(nxtM2);
movePalletM.SendToNXT(nxtM3);
for i=1:1:n

    [y1(i),y8(i),stdarray1,array1] = averagestd(nxtU,SENSOR_2,stdarray1,array1);
    [y2(i),y9(i),stdarray2,array2] = averagestd(nxtM1,SENSOR_1,stdarray2,array2);
    [y3(i),y10(i),stdarray3,array3] = averagestd(nxtM1,SENSOR_2,stdarray3,array3);
    [y4(i),y11(i),stdarray4,array4] = averagestd(nxtM2,SENSOR_1,stdarray4,array4);
    [y5(i),y12(i),stdarray5,array5] = averagestd(nxtM2,SENSOR_2,stdarray5,array5);
    [y6(i),y13(i),stdarray6,array6] = averagestd(nxtM3,SENSOR_1,stdarray6,array6);
    [y7(i),y14(i),stdarray7,array7] = averagestd(nxtM3,SENSOR_2,stdarray7,array7);
    pause(0.04);

end
movePalletU.Stop('off', nxtU);
movePalletU.Stop('off', nxtS);
movePalletM.Stop('off', nxtM1);
movePalletM.Stop('off', nxtM2);
movePalletM.Stop('off', nxtM3);
figure
plot(x,y1,x,y2,x,y3,x,y4,x,y5,x,y6,x,y7)
legend('upstream','main1','main1','main2','main2','main3','main3')
%legend('upstream','main1','main2','main3')
figure
plot(x,y8,x,y9,x,y10,x,y11,x,y12,x,y13,x,y14)
legend('upstream','main1','main1','main2','main2','main3','main3')
%legend('upstream','main1','main2','main3')
CloseSensor(SENSOR_1, nxtM1);
CloseSensor(SENSOR_2, nxtM1);
CloseSensor(SENSOR_1, nxtM2);
CloseSensor(SENSOR_2, nxtM2);
CloseSensor(SENSOR_1, nxtM3);
CloseSensor(SENSOR_2, nxtM3);
CloseSensor(SENSOR_2, nxtU);
COM_CloseNXT('all');