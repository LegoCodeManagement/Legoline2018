function result = resetTransferArm(motor, touch, nxt, degree)
    resetArm1 = NXTMotor(motor);
    resetArm1.Power = 20;
    resetArm1.SpeedRegulation=0;
    resetArm2 = NXTMotor(motor);
    resetArm2.Power = -20;
    resetArm2.SpeedRegulation = 0;
    resetArm2.TachoLimit = degree;
    resetArm2.ActionAtTachoLimit = 'brake';
    resetArm1.SendToNXT(nxt);
    tic;
    currentTime = toc;
    while GetSwitch(touch, nxt) == 0
        if (toc - currentTime > 4)
            disp('Error reseting transfer arm');
            resetArm1.Stop('off', nxt);
            result = false;
            return;
        end
    end
    resetArm1.Stop('brake', nxt);
    pause(0.3);
    resetArm2.SendToNXT(nxt);
    result = resetArm2.WaitFor(2, nxt);
    resetArm2.Stop('off', nxt);
end