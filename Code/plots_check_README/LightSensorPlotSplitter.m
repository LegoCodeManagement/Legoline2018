SAddr = '001653132A78';
nxtS = COM_OpenNXTEx('USB', SAddr);

OpenLight(SENSOR_2, 'ACTIVE', nxtS);
OpenColor(SENSOR_3, nxtS);

input('press ENTER to start');

movePalletS = NXTMotor(MOTOR_B);
movePalletS.Power = 35; 
movePalletS.SpeedRegulation = 0;

%{
n=400;
m=5;
k=7;
x=linspace(0,5,n);    
y1  = zeros(1, n); stdarray1 = zeros(1,m);
y2  = zeros(1, n); stdarray2 = zeros(1,m);
y3  = zeros(1, n); stdarray3 = zeros(1,m);
y4  = zeros(1, n); stdarray4 = zeros(1,m); 
y5  = zeros(1, n); stdarray5 = zeros(1,m);
y6  = zeros(1, n); stdarray6 = zeros(1,m); 
y7  = zeros(1, n); stdarray7 = zeros(1,m);
y8  = zeros(1, n); array1 = ones(1,k)*GetLight(SENSOR_2, nxtU);
y9  = zeros(1, n); array2 = ones(1,k)*GetLight(SENSOR_1, nxtM1);
y10 = zeros(1, n); array3 = ones(1,k)*GetLight(SENSOR_2, nxtM1);
y11 = zeros(1, n); array4 = ones(1,k)*GetLight(SENSOR_1, nxtM2);
y12 = zeros(1, n); array5 = ones(1,k)*GetLight(SENSOR_2, nxtM2);
y13 = zeros(1, n); array6 = ones(1,k)*GetLight(SENSOR_1, nxtM3);
y14 = zeros(1, n); array7 = ones(1,k)*GetLight(SENSOR_2, nxtM3);
%}

movePalletS.SendToNXT(nxtS);

r = []; g = []; b = [];

for i=1:1:n
%{
    [y1(i),y8(i),stdarray1,array1]  = averagestd(nxtU ,SENSOR_2,stdarray1,array1);
    [y2(i),y9(i),stdarray2,array2]  = averagestd(nxtM1,SENSOR_1,stdarray2,array2);
    [y3(i),y10(i),stdarray3,array3] = averagestd(nxtM1,SENSOR_2,stdarray3,array3);
    [y4(i),y11(i),stdarray4,array4] = averagestd(nxtM2,SENSOR_1,stdarray4,array4);
    [y5(i),y12(i),stdarray5,array5] = averagestd(nxtM2,SENSOR_2,stdarray5,array5);
    [y6(i),y13(i),stdarray6,array6] = averagestd(nxtM3,SENSOR_1,stdarray6,array6);
    [y7(i),y14(i),stdarray7,array7] = averagestd(nxtM3,SENSOR_2,stdarray7,array7);
%}

	[~, r0 g0 b0] = GetColor(SENSOR_3, 0, nxtS);
	r = [r,r0]; g = [g,g0]; r = [g,g0]; 
	

    pause(0.04);

end

movePalletS.Stop('off', nxtS);

figure
plot(x,r,'r',x,g,'g',x,b,'b');
legend('red','green','blue')
%legend('upstream','main1','main2','main3')

CloseSensor(SENSOR_2, nxtS);
CloseSensor(SENSOR_3, nxtS);
COM_CloseNXT('all');