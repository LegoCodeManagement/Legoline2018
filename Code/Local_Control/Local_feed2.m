addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(8) = 49;
b2 = memmapfile('buffer2.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2
%respectively.
cd ../
config = fopen('config.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power = str2double(out{2}(strcmp('line_speed',out{1})));
F2addr = char(out{2}(strcmp('Feed2',out{1})));
T_F2 = str2double(out{2}(strcmp('T_F2',out{1})));
Fthreshold = str2double(out{2}(strcmp('Fthreshold',out{1})));	
nxtF2 = COM_OpenNXTEx('USB', F2addr);

dist 		= str2double(out{2}(strcmp('dist_choice',out{1})));
poiss_mean 	= str2double(out{2}(strcmp('poisson_mean',out{1})));
unif_max 	= str2double(out{2}(strcmp('uniform_max',out{1})));
unif_min 	= str2double(out{2}(strcmp('uniform_min',out{1})));
triang_max  = str2double(out{2}(strcmp('triangular_max',out{1})));
triang_min  = str2double(out{2}(strcmp('triangular_min',out{1})));
triang_mode = str2double(out{2}(strcmp('triangular_mode',out{1})));
buffer 		= str2double(out{2}(strcmp('buffer_size',out{1})));

%activate sensors
OpenSwitch(SENSOR_1, nxtF2);
OpenLight(SENSOR_3, 'ACTIVE', nxtF2);

%signal that this module is ready
fstatus.Data(8) = 50;
disp('FEED 2');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.3);
end

%calculate the background light in the room. Further measurements will be measured as a difference to this.
currentLight3 = GetLight(SENSOR_3, nxtF2);

timer1 = tic;
timer2 = tic;
feedtime = 0;
k=0;
%feed all the pallets or until told to stop.
while (k<12) && (fstatus.Data(1) == 49)
	if (toc(timer1) >= feedtime) %true if it's time to feed
		if b2.Data(1) == 48
			b2.Data(1) = b2.Data(1) + 1;
			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feedtime)]);
			feedPallet(nxtF2, SENSOR_1, MOTOR_A);
			k=k+1;
			timer1 = tic
			switch dist %dist will never change unless file is re-read
						%but switch statement repeatedly checks value of dist - inefficient?
				case 0
					feedtime = T_F2;
				case 1
					feedtime = randraw('uniform',[unif_min,unif_max],1);
				case 2
					feedtime = randraw('exp',(1/poiss_mean),1);
				case 3
					feedtime = randraw('tri',[triang_min,triang_mode,triang_max],1);
				otherwise
					disp('error, wrong input distribution')
					logwrite('invalid input distribution')
					fstatus.Data(1) = 50;
		
		elseif b2.Data(1) < 48+buffer
                      
			movePalletSpacing(400, MOTOR_B, power, nxtF2); %move pallet already on feed line out the way
			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feedtime)]);
			b2.Data(1) = b2.Data(1) + 1;
			feedPallet(nxtF2, SENSOR_1, MOTOR_A);
			k=k+1;
			timer1 = tic
			switch dist %dist will never change unless file is re-read
						%but switch statement repeatedly checks value of dist - inefficient?
				case 0
					feedtime = T_F2;
				case 1
					feedtime = randraw('uniform',[unif_min,unif_max],1);
				case 2
					feedtime = randraw('exp',(1/poiss_mean),1);
				case 3
					feedtime = randraw('tri',[triang_min,triang_mode,triang_max],1);
				otherwise
					disp('error, wrong input distribution')
					logwrite('invalid input distribution')
					fstatus.Data(1) = 50;
				
		elseif b2.Data(1) == 48+buffer
			disp(['cannot feed there are ',num2str(b2.Data(1)),' pallets on feed line']);
			logwrite(['buffer exceeded, there were ',num2str(b2.Data(1)),' pallets on feed line 2']);
			fstatus.Data(1)=50;
			break;
			
		else
			disp(['error, there are ',num2str(b2.Data(1)),' pallets on feed line 2']);
			logwrite(['error, there are ',num2str(b2.Data(1)),' pallets on feed line 2']);
			fstatus.Data(1)=50;
			break;
		end
	end
	switch b2.Data(2)
		case 48
			switch b2.Data(1)
				case 48
					pause(0.1);
				case 49
					movePalletPastLSfeed(MOTOR_B, power, nxtF2, SENSOR_3, 6, Fthreshold);
					b2.Data(1) = b2.Data(1) - 1;
			
				case 50
					movePalletSpacing(500, MOTOR_B, power, nxtF2);
					pause(1);
					b2.Data(1) = b2.Data(1) - 1;
					movePalletSpacing(450, MOTOR_B, -power, nxtF2);
					
				otherwise
					disp(['error, there are ',num2str(b2.Data(1)),' pallets on feed line']);
					logwrite(['error, there were ',num2str(b2.Data(1)),' pallets on feed line 2']);
					break;
			end
			
		case 49
		disp('waiting for pallet on transfer line');
        disp(['transfer buffer = ', num2str(b2.Data(2))]);
        disp(['feed buffer = ', num2str(b2.Data(1))]);
        disp(' ');
        pause(0.3);
	end
	
	pause(0.2)  %to avoid update error
end

disp('Feed 2 STOPPED')
clear b2;
CloseSensor(SENSOR_1, nxtF2);
CloseSensor(SENSOR_3, nxtF2);
COM_CloseNXT(nxtF2);
quit;