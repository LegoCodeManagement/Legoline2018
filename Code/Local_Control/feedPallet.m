function result = feedPallet(nxtFeed, touchSensor, liftMotor)
initMotor = NXTMotor(liftMotor);
initMotor.Power = -50;
initMotor.SpeedRegulation = 0;
pushPallet = NXTMotor(liftMotor,'Power',65);
pushPallet.SpeedRegulation=0;
pushPallet.TachoLimit=157;%Between 110+30 and 120+30 would do
pushPallet.ActionAtTachoLimit='Coast';
initMotor.SendToNXT(nxtFeed);
tic;
currentTime = toc;
while GetSwitch(touchSensor, nxtFeed) == 0
    if (toc - currentTime > 1.5)
        disp('Error reseting feeding unit');
        initMotor.Stop('off', nxtFeed);
        result = false;
        return;
    end
end
pause(0.03);
initMotor.Stop('brake', nxtFeed);

pushPallet.SendToNXT(nxtFeed);
result = pushPallet.WaitFor(1.5, nxtFeed); %return 0 if the motor commands is finished otherwise return 1;
if (result == 1)
    disp('Error feeding pallets');
    pushPallet.Stop('off', nxtFeed);
end
