COM_CloseNXT('all');

T1 = '0016530AABDF';
T2 = '0016530EE129';
T3 = '0016530A6F56';

degree = 110;

nxtAddr = T1;
nxt = COM_OpenNXTEx('USB',nxtAddr);

out = NXTMotor(MOTOR_B);
out.Power = -20;
out.TachoLimit = degree;

infast = NXTMotor(MOTOR_B);
infast.Power = 20;
infast.TachoLimit = degree;

inslow = NXTMotor(MOTOR_B);
inslow.Power = 1;


out.SendToNXT(nxt);
out.WaitFor(0,nxt);
infast.SendToNXT(nxt);
infast.WaitFor(0,nxt);
inslow.SendToNXT(nxt);
pause(1)
inslow.Stop('off',nxt)

