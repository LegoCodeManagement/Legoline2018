function result = resetSplitterArm(nxt, touch, motor, timeOut)
%function result = resetSplitterArm(nxt, touch, motor, timeOut)
resetArm = NXTMotor(motor);
resetArm.Power = 50;
resetArm.SpeedRegulation = 0;
resetArm.SendToNXT(nxt);
result = true;
tic;
currentTime = toc;
while GetSwitch(touch, nxt) == 0
    if toc - currentTime > timeOut
        disp('The touch sensor hasnt been pressed. Reset fails');
        result = false;
        break;
    end
    pause(0.05);
end
resetArm.Stop('off', nxt);
end