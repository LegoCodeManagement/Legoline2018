addpath RWTHMindstormsNXT;
%establish memory map to status.txt.
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(11) = 49;
b3 = memmapfile('buffer3.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2
%respectively.
cd(['..',filesep])
config = fopen('config.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(config, '%s %s %s %s %s');
fclose(config);
%retrieve parameters
power 		= str2double(out{2}(strcmp('line_speed',out{1})));
F1addr 		= char(out{2}(strcmp('Feed1',out{1})));
T_F1 		= str2double(out{2}(strcmp('T_F1',out{1})));
Fthreshold 	= str2double(out{2}(strcmp('Fthreshold',out{1})));	
nxtF1 		= COM_OpenNXTEx('USB', F1addr);
clear out

cd(['..',filesep])
param = fopen('Parameters.txt','rt');
cd([pwd,filesep,'Local_Control']);
out = textscan(param, '%s %s %s %s %s');
fclose(param);
row 	= find(strcmp('ControlUpstr',out{1}));

dist    = char(out{2}(row));
param1  = str2double(out{3}(row));
param2  = str2double(out{4}(row));
param3  = str2double(out{5}(row));
row 	= find(strcmp('Line3',out{1}));
%buffer is line 3
buffer 	= str2double(out{3}(row));

%activate sensors
OpenSwitch(SENSOR_1, nxtF3);
OpenLight(SENSOR_3, 'ACTIVE', nxtF3);

%signal that this module is ready
fstatus.Data(11) = 50;
disp('FEED 3');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously
while fstatus.Data(1) == 48
    pause(0.3);
end

%calculate the background light in the room. Further measurements will be measured as a difference to this.
currentLight3 = GetLight(SENSOR_3, nxtF3);

timer1 = tic;
timer2 = tic;
feedtime = 0;
k=0;
%feed all the pallets or until told to stop.
while (k<12) && (fstatus.Data(1) == 49)
	if (toc(timer1) >= feedtime) %true if it's time to feed
		if b3.Data(1) == 48
			b3.Data(1) = b3.Data(1) + 1;
			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feedtime)]);
			feedPallet(nxtF3, SENSOR_1, MOTOR_A);
			k=k+1;
			timer1 = tic
			switch dist %dist will never change unless file is re-read
						%but switch statement repeatedly checks value of dist - inefficient?
				case 0
					feedtime = T_F3;
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
		
		elseif b3.Data(1) < 48+buffer
                      
			movePalletSpacing(400, MOTOR_B, power, nxtF1); %move pallet already on feed line out the way
			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feedtime)]);
			b3.Data(1) = b3.Data(1) + 1;
			feedPallet(nxtF3, SENSOR_1, MOTOR_A);
			k=k+1;
			timer1 = tic
			switch dist %dist will never change unless file is re-read
						%but switch statement repeatedly checks value of dist - inefficient?
				case 0
					feedtime = T_F3;
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
				
		elseif b3.Data(1) == 48+buffer
			disp(['cannot feed there are ',num2str(b3.Data(1)),' pallets on feed line 3']);
			logwrite(['buffer exceeded, there were ',num2str(b3.Data(1)),' pallets on feed line 3']);
			fstatus.Data(1)=50;
			break;
		else
			disp(['error, there are ',num2str(b3.Data(1)),' pallets on feed line']);
			logwrite(['error, there are ',num2str(b3.Data(1)),' pallets on feed line 1']);
			fstatus.Data(1)=50;
			break;
		end
	end
	switch b3.Data(2)
		case 48
			switch b3.Data(1)
				case 48
					pause(0.1);
				case 49
					movePalletPastLSfeed(MOTOR_B, power, nxtF3, SENSOR_3, 6, Fthreshold);
					b3.Data(1) = b3.Data(1) - 1;
				case 50
					movePalletSpacing(500, MOTOR_B, power, nxtF3);
					pause(1);
					b3.Data(1) = b3.Data(1) - 1;
					movePalletSpacing(350, MOTOR_B, -power, nxtF3);
					
				otherwise
					disp(['error, there are ',num2str(b3.Data(1)),' pallets on feed line 3']);
					logwrite(['error, there were ',num2str(b3.Data(1)),' pallets on feed line 3']);
					break;
			end
			
		case 49
		disp('waiting for pallet on transfer line');
        disp(['transfer buffer = ', num2str(b3.Data(2))]);
        disp(['feed buffer = ', num2str(b3.Data(1))]);
        disp(' ');
        pause(0.3);	
	end
	
	pause(0.2)  %to avoid update error
end

disp('Feed 3 STOPPED')
clear b3;
CloseSensor(SENSOR_1, nxtF3);
CloseSensor(SENSOR_3, nxtF3);
COM_CloseNXT(nxtF3);
quit;