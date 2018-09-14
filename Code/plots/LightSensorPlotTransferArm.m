addpath RWTHMindstormsNXT;
T1addr = '0016530AABDF';

nxtT1 = COM_OpenNXTEx('USB', T1addr);

OpenLight(SENSOR_3, 'ACTIVE', nxtT1);

movePalletT = NXTMotor(MOTOR_A);
movePalletT.Power = -40; 
movePalletT.SpeedRegulation = 0;
n=100;
x=linspace(0,5,n);    
y1  = zeros(1, n); stdarray1 = zeros(1,7);
y3  = zeros(1, n); array1 = ones(1,10)*GetLight(SENSOR_3, nxtT1);

movePalletT.SendToNXT(nxtT1);
for i=1:1:n
    [y1(i),y3(i),stdarray1,array1] = averagestd(nxtT1,SENSOR_3,stdarray1,array1);
    pause(0.04);
end
movePalletT.Stop('off', nxtT1);


figure
plot(x,y1)
figure
plot(x,y3)

CloseSensor(SENSOR_3, nxtT1);
COM_CloseNXT('all');