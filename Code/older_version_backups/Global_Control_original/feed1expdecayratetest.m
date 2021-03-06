T_F1 = 10;
a = 0.05;

 %start with a number greater than T_F1 so that feed starts immediately

k=0; 
buffer1 = 0;
buffer2 = 0;
timer1 = tic;
timer2 = tic;
disp([num2str(toc(timer1)),', ',num2str(toc(timer2))])
while (k<12)
	if toc(timer1) > T_F1*exp(-a*toc(timer2))
		switch buffer1
    		case 0
    			k=k+1;
				disp([num2str(toc(timer1)),', ',num2str(toc(timer2))]);
                %timer1 vs timer2 is exponentially decaying. (ie pallet
                %feed time vs simulation time.)
				timer1 = tic; %set timer for next pallet

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
	
	pause(0.1)  %to avoid update error. 0.1 gives little error in skewing distribution
end