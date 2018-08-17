addpath RWTHMindstormsNXT;
%establish memory map to status.txt. 
fstatus = memmapfile('status.txt', 'Writable', true, 'Format', 'int8');
fstatus.Data(5) = 49;
b1 = memmapfile('buffer1.txt', 'Writable', true, 'Format', 'int8');

%open config file and save variable names and values column 1 and 2
%respectively.
config = fopen('config.txt','rt');
out = textscan(config, '%s %s');
fclose(config);
%retrieve parameters
power 		= str2double(out{2}(strcmp('SPEED_F',out{1})));
F1addr 		= char(out{2}(strcmp('Feed1',out{1})));
%T_F1 		= str2double(out{2}(strcmp('T_F1',out{1})));
Fthreshold  = str2double(out{2}(strcmp('Fthreshold',out{1})));	
nxtF1 		= COM_OpenNXTEx('USB', F1addr);



OpenSwitch(SENSOR_1, nxtF1);
OpenLight(SENSOR_3, 'ACTIVE', nxtF1);

%signal that this module is ready
fstatus.Data(5) = 50;
disp('FEED 1');
disp('waiting for ready signal');
%wait for ready sign so that all matlab instances start simultaneously

while fstatus.Data(1) == 48
    pause(0.1);
end

currentLight3 = GetLight(SENSOR_3, nxtF1);

T_F1 = 8;
%feed first pallet

feedtime = 0;

timer1 = tic;
timer2 = tic;

while (fstatus.Data(1) == 49)
	if toc(timer1) >= feedtime
		switch b1.Data(1)
    		case 48
    			b1.Data(1) = b1.Data(1) + 1;
    			disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feedtime)]);
				feedPallet(nxtF1, SENSOR_1, MOTOR_A);
				timer1 = tic; %set timer for next pallet
				%feedtime = poissrnd(T_F1); put in a switch statement which reads from other file
				%feedtime = randraw('tri',[lower,T_F1,upper],1);
				feedtime = T_F1;
			
            case 49
				b1.Data(1) = b1.Data(1) + 1;      
                %movePalletSpacing(350, MOTOR_B, power, nxtF1);
                disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-feedtime)]);
                feedPallet(nxtF1, SENSOR_1, MOTOR_A);
                timer1 = tic; %set timer for next pallet
                feedtime = poissrnd(T_F1);

            case 50
				%disp(['cannot feed there are ',num2str(b1.Data(1)),' pallets on feed line']);
			
			otherwise
				disp(['error, there are ',num2str(b1.Data(1)),' pallets on feed line']);
				break;
		end
	end
	switch b1.Data(2)
        case 48
			switch b1.Data(1)
				case 48

				case 49
					movePalletPastLSfeed(MOTOR_B, power, nxtF1, SENSOR_3, 10, Fthreshold);
					b1.Data(1) = b1.Data(1) - 1;
			
                case 50

					movePalletSpacing(500, MOTOR_B, power, nxtF1);
					pause(0.5)
					b1.Data(1) = b1.Data(1) - 1;
					%movePalletSpacing(350, MOTOR_B, -power, nxtF1);
					
				otherwise
					disp(['error, there are ',num2str(b1.Data(1)),' pallets on feed line']);
					break;
			end
			
        case 49
		%disp('waiting for pallet on transfer line');
        %disp(['transfer buffer = ', num2str(b1.Data(2))]);
        %disp(['feed buffer = ', num2str(b1.Data(1))]);
        %disp(' ');
        pause(0.3);
	end
	
	pause(0.1)  %to avoid update error
end

disp('Feed 1 STOPPED')
clear b1;
CloseSensor(SENSOR_1, nxtF1);
CloseSensor(SENSOR_3, nxtF1);
COM_CloseNXT(nxtF1);
			