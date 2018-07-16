COM_CloseNXT('all')
Uaddr = '0016530EE120';
U = COM_OpenNXTEx('USB', Uaddr);

disp('UPSTREAM')

j1 = memmapfile('Junction1.txt','Writable',true);

disp(j1.Data(1));

OpenLight(SENSOR_2,'ACTIVE',U)
OpenSwitch(SENSOR_1,U)

input('Press ENTER to start')

currentValueU = GetLight(SENSOR_2,U);

palletHasLeft = [timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3);
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3);
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3);
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3); 
                 timer('TimerFcn','j1.Data(1) = j1.Data(1) - 1','StartDelay',3)];

T_U = 6;
toc = T_U + 1;
j=0;
tic;
while j<6
	if toc > T_U
		j1.Data(1) = j1.Data(1) + 1;
		clear toc
		tic
		feedPallet(U,SENSOR_1,MOTOR_A);
		j=j+1;
		movePalletToLightSensor(MOTOR_B,30,U,SENSOR_2,currentValueU,20);
		start(palletHasLeft(j));
	end
	pause(0.25)
end

delete(timerfind);
disp('upstream STOPPED')
clear j1;
CloseSensor(SENSOR_1, nxtF1);
CloseSensor(SENSOR_2, nxtF1);
COM_CloseNXT(nxtU);
