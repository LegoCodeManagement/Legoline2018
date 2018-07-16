addpath RWTHMindstormsNXT;
COM_CloseNXT('all');

%Transfer Line 1 is Okay now do not change  TEST_Feed1 and TEST_Transfer1
%Transfer Line 1 and 2 are Okay now do not change  TEST_Feed2 and
%TEST_Transfer2
%anymore
%Try memory map to communicate between multiple instances or shared matrix
%The delay here is significant

run initialise

!matlab  -nodesktop -minimize -nosplash -r BUFFERfeed1&
!matlab  -nodesktop -minimize -nosplash -r BUFFERtransfer1&
!matlab  -nodesktop -minimize -nosplash -r BUFFERmainline1&
!matlab  -nodesktop -minimize -nosplash -r BUFFERupstream&

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(1) = 48;
input('press ENTER to start Legoline');
fstatus.Data(1) = 49;
input('press ENTER to stop Legoline');
fstatus.Data(1) = 50;

