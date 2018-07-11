function result = runSplitterArm(nxt, motor, timeOut)
    splitter = NXTMotor(motor);
    splitter.SpeedRegulation = 0;
    splitter.Power = -50;
    splitter.TachoLimit = 280;
    splitter.ActionAtTachoLimit = 'Coast';
    splitter.SendToNXT(nxt);
    result = splitter.WaitFor(timeOut, nxt);
end