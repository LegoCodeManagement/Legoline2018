%Attemp to transfer the pallet to the mainline without the arm.]
%Sometimes successful but we need to stop the transfer line at a very
%precise time to ensure maximal smoothness
COM_CloseNXT('all');
nxtT1Addr = '0016530AABDF';
nxtM1Addr = '0016530EE594';
nxtT1 = COM_OpenNXTEx('USB', nxtT1Addr);
nxtM1 = COM_OpenNXTEx('USB', nxtM1Addr);
keepTransferRunning = NXTMotor(MOTOR_A);
keepTransferRunning.SpeedRegulation = false;
keepTransferRunning.Power = -60;
keepTransferRunning.SendToNXT(nxtT1);
keepTransferRunning.SendToNXT(nxtM1);
input('Press enter');
keepTransferRunning.Stop('off', nxtT1);
input('Press enter again');
keepTransferRunning.SendToNXT(nxtT1);
input('Press enter');
keepTransferRunning.Stop('off', nxtT1);
input('Press enter again');
keepTransferRunning.SendToNXT(nxtT1);
input('Press enter');
keepTransferRunning.Stop('off', nxtT1);
input('Press enter again');
keepTransferRunning.SendToNXT(nxtT1);
input('Press enter');
keepTransferRunning.Stop('off', nxtT1);
input('Press enter again');
keepTransferRunning.SendToNXT(nxtT1);
input('Press enter');
keepTransferRunning.Stop('off', nxtT1);
input('Press enter again');
keepTransferRunning.SendToNXT(nxtT1);
input('Press enter');
keepTransferRunning.Stop('off', nxtT1);
keepTransferRunning.Stop('off', nxtM1);
COM_CloseNXT(nxtM1);
COM_CloseNXT(nxtT1);