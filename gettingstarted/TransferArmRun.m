function result = runTransferArm(motor, nxt, degree)
    transfer=NXTMotor(motor);
    transfer.Power=-30;
    transfer.SpeedRegulation=0;
    transfer.TachoLimit=degree;
    transfer.ActionAtTachoLimit='brake';
    transfer.SendToNXT(nxt);
    result = transfer.WaitFor(4, nxt);
    transfer.Stop('off', nxt);
end