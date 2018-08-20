F1addr = '00165308EE03';
T1addr = '0016530AABDF';

%{
T2addr	= '0016530EE129';
F2addr	= '001653118A50';
%}

%{
T3addr 	= '0016530A6F56';
F3addr	= '0016530D6831';
%}

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

n=100;

x=linspace(0,5,n);    
y1  = zeros(1, n); stdarray1 = zeros(1,7);
y2  = zeros(1, n); stdarray2 = zeros(1,7);
y3  = zeros(1, n); array1 = ones(1,10)*GetLight(SENSOR_3, nxtF1);
y4  = zeros(1, n); array2 = ones(1,10)*GetLight(SENSOR_1, nxtT1);

movePalletF.SendToNXT(nxtF1);
movePalletT.SendToNXT(nxtT1);
for i=1:1:n

    [y1(i),y3(i),stdarray1,array1] = averagestd(nxtF1,SENSOR_3,stdarray1,array1);
    [y2(i),y4(i),stdarray2,array2] = averagestd(nxtT1,SENSOR_1,stdarray2,array2);

    pause(0.04);
%if std > threshold, keep running motor til light avg returns below some other threshold to push stuck pallets.
end
movePalletF.Stop('off', nxtF1);
movePalletT.Stop('off', nxtT1);
figure
plot(x,y1,x,y2)
%legend('upstream','main1','main1','main2','main2','main3','main3')
legend('feed','transfer')
figure
plot(x,y3,x,y4)
legend('feed','transfer')
CloseSensor(SENSOR_1, nxtT1);
CloseSensor(SENSOR_3, nxtF1);
COM_CloseNXT('all');