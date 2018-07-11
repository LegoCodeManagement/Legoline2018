%movePalletSpacing(spacing, motor, power, nxt)
function result = movePalletSpacing(angle,motor,power,nxt)

movePallet = NXTMotor(motor);
movePallet.Power = power;
movePallet.SpeedRegulation = 0;
movePallet.TachoLimit = angle;
movePallet.SendToNXT(nxt);
movePallet.WaitFor(3, nxt);
end