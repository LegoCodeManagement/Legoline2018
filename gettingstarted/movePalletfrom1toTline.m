function result = movePalletfrom1toTline(motor, power, nxt)

%might be worth using light sensor to detect when pallet has left

movePallet = NXTMotor(motor,'Power',power);
movePallet.TachoLimit = 400;
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);
movePallet.WaitFor(3, nxt);
end