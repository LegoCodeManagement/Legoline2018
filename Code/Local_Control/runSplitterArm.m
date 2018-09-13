function result = runSplitterArm(nxt, motor, timeOut)
    splitter = NXTMotor(motor);
    splitter.SpeedRegulation = 0;
    splitter.Power = -50;
    splitter.TachoLimit = 360;
    splitter.ActionAtTachoLimit = 'brake';
    splitter.SendToNXT(nxt);
    result = splitter.WaitFor(timeOut, nxt);
end