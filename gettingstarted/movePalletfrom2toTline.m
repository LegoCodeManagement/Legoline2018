function result = movePalletfrom2toTline(motor, power, nxt)

%might be worth using light sensor to detect when pallet has left

movePallet = NXTMotor(motor,'Power',power);
movePallet.TachoLimit = 200;
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);
movePallet.WaitFor(3, nxt);
end