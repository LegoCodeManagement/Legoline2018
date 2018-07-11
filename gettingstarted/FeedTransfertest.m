COM_CloseNXT('all');

T1 = '0016530AABDF';
T2 = '0016530EE129';
T3 = '0016530A6F56';

nxtAddr = T2;
nxt = COM_OpenNXTEx('USB',nxtAddr);

OpenLight(SENSOR_3, 'ACTIVE', nxt);
OpenSwitch(SENSOR_2, nxt);
OpenLight(SENSOR_1, 'ACTIVE', nxt);

%T1 callibration angle = 19
%T2 callibration angle = 10
%T3 callibration angle = 10



resetTransferArm(MOTOR_B,SENSOR_2, nxt, 10);
OpenLight(SENSOR_3,'ACTIVE',nxt)
currentLight3 = GetLight(SENSOR_3,nxt);

tic;
currentTime=toc;

feedline = NXTMotor(MOTOR_A,'Power',-30);
feedline.SpeedRegulation = false;
feedline.SendToNXT(nxt);

while (abs(GetLight(SENSOR_3,nxt)-currentLight3)<50)
    if (toc-currentTime) > 6
        disp('timeout');
        feedline.Stop('off',nxt);
        return
    end
end
feedline.Stop('off',nxt);

runTransferArm(MOTOR_B,nxt,105)

