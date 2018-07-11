COM_CloseNXT('all');

%Transfer Line 1 is Okay now do not change  TEST_Feed1 and TEST_Transfer1
%Transfer Line 1 and 2 are Okay now do not change  TEST_Feed2 and
%TEST_Transfer2
%anymore
%Try memory map to communicate between multiple instances or shared matrix
%The delay here is significant
!matlab  -nodesktop -minimize -nosplash -r TESTfeedwithbuffer&
!matlab  -nodesktop -minimize -nosplash -r TESTtransferwithbuffer&
!matlab  -nodesktop -minimize -nosplash -r TESTmainline&
!matlab  -nodesktop -minimize -nosplash -r TESTupstream

%!matlab  -nodesktop -minimize -nosplash -r TESTmainline&
%!matlab  -nodesktop -minimize -nosplash -r TESTupstream&
%!matlab  -nodesktop -minimize -nosplash -r TESTfeed&
%!matlab  -nodesktop -minimize -nosplash -r TESTtransfer

%!matlab  -nodesktop -minimize -nosplash -r TESTpalletmanualreset
%!matlab  -nodesktop -minimize -nosplash -r TEST_Transfer2&
%!matlab  -nodesktop -minimize -nosplash -r TEST_Feed2&
%!matlab  -nodesktop -minimize -nosplash -r TEST_Transfer3&
%!matlab  -nodesktop -minimize -nosplash -r TEST_Feed3&
%!matlab  -nodesktop -minimize -nosplash -r TEST_MainLine&
