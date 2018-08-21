Addresses:
%NXT addresses required to establish a connection with MATLAB

Speed_Settings:
%Speed of conveyors for each module

% S = Splitter
% T = Transfer
% M = Main
% F = Feed 
% U = Upstream

Transfer_Arm_Calibration_Angles:
Angle at which to reset the transfer arm once triggering touch sensor. Since the Transfer 1 module is adjacent to the Upstream module, a half-beam must be used to trigger the T1 touch sensor, in order to avoid a clash with with the U motor. (Thus gives a difference in reset angle for T1 compared to T2,T3).

Feed_Frequencies
Rate of pallet output for each feed module. Currently a uniform output; I will implement varying output frequency.

% 1 = uniform
% 2 = poisson
% 3 = triangular

Pallet_has_left delay:
E.g j1 is increased by 1 when T1 puts a pallet onto the mainline. After a delay, j1 is then reduced by one to represent the pallet leaving the M1 section of the mainline. The value of Pallet_has_left is this delay.

Timing_Values:

MainlinePass
%Time in seconds which transfer unit waits before placing another pallet when it detects a pallet passing under the mainline sensors

PalletUnloadPause
%Minimum time in seconds between which transfer unit will take before placing another pallet onto the mainline. Needs to be the time it takes for the previous pallet to just clear the "lift" on the mainline.

FeedUnloadPause
%Time in seconds that feed unit pauses when end of transfer unit clears before passing on another pallet. This time needs to be greater than the time it takes for the transfer unit "swing" arm to unload a pallet and retract.

TransientPause
%Time in seconds that pallet pauses at end of feed unit conveyor, before passing on to transfer unit. Needed to cope with circumstances where pallet is just being unloaded, but light sensor has yet to pick this up. In this situation, the pallet will be passed on while the transfer unit is feeding which is not allowed. Within 2 seconds, either the transfer unit will have began feeding and the feed unit will see the pallet state go to 0, or the transfer unit will not feed and wait for the feed unit.


Splitter_Timings:
% Splitter Timings for when the sensor is read
% bit 1 is read between t1 and t2, bit 2 is read between t3 and t4, bit 3 is read between t5 and t6; these should only be changed if the belt running speed is read. 	

T1
T2
T3
T4
T5
T6

% splitter Spike Threshold- the difference between the average and spiked light level that triggers the detection as a zero bit.  
SPIKE


