COM_CloseNXT('all');
nxtM1Addr = '0016530EE594';
nxtM2Addr = '001653118AC9';
nxtM3Addr = '001653118B91';
%It takes a while to connect to the NXTs. If I place this block of code
%after the file modification the mainline is going to start after the other
%three units start
nxtM1 = COM_OpenNXTEx('USB', nxtM1Addr);
nxtM2 = COM_OpenNXTEx('USB', nxtM2Addr);
nxtM3 = COM_OpenNXTEx('USB', nxtM3Addr);
keepMainlineRunning = NXTMotor(MOTOR_A);
keepMainLineRunning.SpeedRegulation = false;
keepMainlineRunning.Power = -40;
filename = 'Temp.txt';
m = memmapfile(filename, 'Writable', true);
m.Data(1) = 2;
clear m;
keepMainlineRunning.SendToNXT(nxtM1);
keepMainlineRunning.SendToNXT(nxtM2);
keepMainlineRunning.SendToNXT(nxtM3);
input('Hit return to stop the mainline');
keepMainlineRunning.Stop('off', nxtM1);
keepMainlineRunning.Stop('off', nxtM2);
keepMainlineRunning.Stop('off', nxtM3);
COM_CloseNXT('all');
quit