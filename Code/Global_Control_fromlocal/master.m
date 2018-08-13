addpath RWTHMindstormsNXT;
COM_CloseNXT('all');

%Transfer Line 1 is Okay now do not change  TEST_Feed1 and TEST_Transfer1
%Transfer Line 1 and 2 are Okay now do not change  TEST_Feed2 and
%TEST_Transfer2
%anymore
%Try memory map to communicate between multiple instances or shared matrix
%The delay here is significant

fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(1) = 48;

for i=1:1:12
    fstatus.Data(i) = 48;
end

run initialise

!matlab  -nodesktop -minimize -nosplash -r Global_display&
!matlab  -nodesktop -minimize -nosplash -r Global_feed1&
!matlab  -nodesktop -minimize -nosplash -r Global_transfer1&
!matlab  -nodesktop -minimize -nosplash -r Global_mainline1&
!matlab  -nodesktop -minimize -nosplash -r Global_upstream&
!matlab  -nodesktop -minimize -nosplash -r Global_feed2&
!matlab  -nodesktop -minimize -nosplash -r Global_transfer2&
!matlab  -nodesktop -minimize -nosplash -r Global_mainline2&
!matlab  -nodesktop -minimize -nosplash -r Global_feed3&
!matlab  -nodesktop -minimize -nosplash -r Global_transfer3&
!matlab  -nodesktop -minimize -nosplash -r Global_mainline3&
!matlab  -nodesktop -minimize -nosplash -r Global_splitter&

u1 = memmapfile('count_u1.txt', 'Writable', true,'Format','int8');
m1 = memmapfile('count_m1.txt', 'Writable', true,'Format','int8');
m2 = memmapfile('count_m2.txt', 'Writable', true,'Format','int8');
b1 = memmapfile('buffer1.txt', 'Writable', true,'Format','int8');
b2 = memmapfile('buffer2.txt', 'Writable', true,'Format','int8');
b3 = memmapfile('buffer3.txt', 'Writable', true,'Format','int8');

for i=1:100
    result = input('Please enter one of the following numbers:\n0 if you want to view the status of initialization\n1 if you want to abort the initialization\n2 If you are happy with the initialization and wish to continue');
	if result == 0
		clc;
		switch fstatus.Data(2)
			case 48
				disp('Upstream:......');
			case 49
				disp('Upstream: Connecting(Maybe failed)');
			case 50
				disp('Upstream: Success');
			otherwise
				disp('Upstream: Error');
		end
		switch fstatus.Data(3)
			case 48
				disp('Main1:......');
			case 49
				disp('Main1: Connecting(Maybe failed)');
			case 50
				disp('Main1: Success');
			otherwise
				disp('Main1: Error');
		end
		switch fstatus.Data(4)
			case 48
				disp('Transfer1:......');
			case 49
				disp('Transfer1: Connecting(Maybe failed)');
			case 50
				disp('Transfer1: Success');
			otherwise
				disp('Transfer1: Error');
		end
		switch fstatus.Data(5)
			case 48
				disp('Feed1:......');
			case 49
				disp('Feed1: Connecting(Maybe failed)');
			case 50
				disp('Feed1: Success');
			otherwise
				disp('Feed1: Error');
		end
		
		switch fstatus.Data(6)
			case 48
				disp('Main2:......');
			case 49
				disp('Main2: Connecting(Maybe failed)');
			case 50
				disp('Main2: Success');
			otherwise
				disp('Main2: Error');
		end
		switch fstatus.Data(7)
			case 48
				disp('Transfer2:......');
			case 49
				disp('Transfer2: Connecting(Maybe failed)');
			case 50
				disp('Transfer2: Success');
			otherwise
				disp('Transfer2: Error');
		end
		switch fstatus.Data(8)
			case 48
				disp('Feed2:......');
			case 49
				disp('Feed2: Connecting(Maybe failed)');
			case 50
				disp('Feed2: Success');
			otherwise
				disp('Feed2: Error');
		end
		switch fstatus.Data(9)
			case 48
				disp('Main3:......');
			case 49
				disp('Main3: Connecting(Maybe failed)');
			case 50
				disp('Main3: Success');
			otherwise
				disp('Main3: Error');
		end
		switch fstatus.Data(10)
			case 48
				disp('Transfer3:......');
			case 49
				disp('Transfer3: Connecting(Maybe failed)');
			case 50
				disp('Transfer3: Success');
			otherwise
				disp('Transfer3: Error');
		end
		switch fstatus.Data(11)
			case 48
				disp('Feed3:......');
			case 49
				disp('Feed3: Connecting(Maybe failed)');
			case 50
				disp('Feed3: Success');
			otherwise
				disp('Feed3: Error');
		end
        %{
		switch fstatus.Data(12)
			case 48
				disp('Splitter1:......');
			case 49
				disp('Splitter1: Connecting(Maybe failed)');
			case 50
				disp('Splitter1: Success');
			otherwise
				disp('Splitter1: Error');
		end
        %}
		
	elseif result == 1
		fstatus.Data(1) = 50; %Let all the other MATLAB instances know that we are shutting down
		clear fstatus;
		clear i;
		clear result;
		clear fstatusStatus;
		clear fileConfig;
	elseif result == 2
        break 
    %{
	elseif result == 2
		clear fstatus;%If user is OK with the initialization, then just quit the program.
		clear i;
		clear result;
		clear fstatusStatus;
		clear fileConfig;
		quit;
	%}
	else
		clc;
		disp('Please enter a valid number');
	end
end

input('press ENTER to start Legoline');
fstatus.Data(1) = 49;
input('press ENTER to stop Legoline');
fstatus.Data(1) = 50;
COM_CloseNXT('all')
