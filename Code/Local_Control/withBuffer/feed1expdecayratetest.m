T_F1 = 5;
a = 0.4
exponentialstep	=	[timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);
					 timer('TimerFcn', 'T_F1 = T_F1*exp(-a);', 'StartDelay', T_F1);];

toc = T_F1; %start with a number greater than T_F1 so that feed starts immediately

k=0; 
buffer1 = 0;
buffer2 = 0;

while (k<12)
	if toc >= T_F1
		switch buffer1
    		case 0
    			k=k+1;
				disp(['feed pallet, T_F1 = ',num2str(T_F1),' toc = ',num2str(toc)]);
				start(exponentialstep(k));
				clear toc
				tic %set timer for next pallet
			
            case 1   
            	k=k+1;         
                disp('movepalletspacing')
                disp(['feed pallet, T_F1 = ',num2str(T_F1)]);
				%start(exponentialstep(k));
				k=k+1;
				clear toc
				tic %set timer for next pallet
				
            case 2
				disp(['cannot feed there are ',num2str(buffer1),' pallets on feed line']);
			
			otherwise
				disp(['error, there are ',num2str(buffer1),' pallets on feed line']);
				break;
		end
	end
	switch buffer2
        case 0
			switch buffer1
			
				case 0
					pause(0.1);
				case 1
					disp('movepalletpastlightsensor')
					%buffer1 = buffer1 - 1;
			
                case 2 
					disp('movepalletpastlightsensor')
					%buffer1 = buffer1 - 1;
					disp('movepalletspacing')
					
				otherwise
					disp(['error, there are ',num2str(buffer1),' pallets on feed line']);
					break;
			end
			
        case 1
		disp('waiting for pallet on transfer line');
        disp(['transfer buffer = ', num2str(buffer2)]);
        disp(['feed buffer = ', num2str(buffer1)]);
        disp(' ');
        pause(0.3);
	end
	
	pause(0.2)  %to avoid update error
end