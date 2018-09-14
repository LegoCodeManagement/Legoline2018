function result = TransferArmRun(motor, nxt, degree)
    transfer=NXTMotor(motor);
    transfer.Power=-40;
    transfer.SpeedRegulation=0;
    transfer.TachoLimit=degree;
    transfer.ActionAtTachoLimit='brake';
    pause(0.5);
    transfer.SendToNXT(nxt);
    result = transfer.WaitFor(4, nxt);
    transfer.Stop('on', nxt);
    pause(0.5)
    transfer.Stop('off', nxt);
end