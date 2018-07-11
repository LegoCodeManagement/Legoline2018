COM_CloseNXT('all');
nxtaddr = '0016530EE120';
nxt = COM_OpenNXTEx('USB',nxtaddr);

OpenSwitch(SENSOR_1,nxt);

uline = NXTMotor(MOTOR_B,'Power',+30,'SpeedRegulation',false);
uline.SendToNXT(nxt)


for i=1:1:2
    uinit = NXTMotor(MOTOR_A,'Power',-20);
    uinit.SendToNXT(nxt);
    tic;
    currentTime = toc;
    while GetSwitch(SENSOR_1,nxt) == 0
        if (toc - currentTime > 2)
            disp('Timeout');
            uinit.Stop('off',nxt);
            return
        end
    end
    uinit.Stop('off',nxt);

    ufeed = NXTMotor(MOTOR_A,'Power',60,'TachoLimit',100,'ActionAtTachoLimit','Coast');
    ufeed.SendToNXT(nxt);
    pause(2)
end

