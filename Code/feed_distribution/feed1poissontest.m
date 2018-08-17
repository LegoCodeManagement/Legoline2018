T_F1 = 10;

k=0; 
buffer1 = 0;
buffer2 = 0;
timer1 = tic;
timer2 = tic;
disp([num2str(toc(timer1)),', ',num2str(toc(timer2))])
feedtime = T_F1*0.1;
x=[];
while (k<60)
	if toc(timer1) >= feedtime
		switch buffer1
    		case 0
    			k=k+1;
				disp([num2str(toc(timer1)),' ',num2str(toc(timer2)),' ',num2str(toc(timer1)-poissrnd(T_F1))]);
				timer1 = tic;
				feedtime = poissrnd(T_F1)*0.1;
				x=[x,feedtime];

            case 1   
            	k=k+1;         
                disp('movepalletspacing')
                disp(['feed pallet, T_F1 = ',num2str(T_F1)]);
				k=k+1;
				clear toc
				tic %set timer for next pallet
				feedtime = poissrnd(T_F1)*0.1;
				
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

        pause(0.1);
	end
	
	pause(0.1)  %to avoid update error. 0.1 gives little error in skewing distribution
end