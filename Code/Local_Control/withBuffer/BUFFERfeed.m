



while 
	tic
	if toc > T
		switch bf
			case bf == 0
				feedpallet()
				bf = bf + 1;
				
		
			case bf == 1 
				feedpallet
				bf = bf + 1;
				
				
			case bf == 2
				disp(['cannot feed there are ',num2str(b.Data(1)),' pallets on feed line']);
				
			
			otherwise
				error
		end
	
	switch bt
		case bt == 0
			
			if bf == 0
			end?
			
			if bf == 1
				move pallet to LS
				bf = bf - 1;
			end
			
			if bf == 2 
				move pallet to LS
				bf = bf - 1;
				movePalletSpacing()
			end
			
		case bt == 1
		disp('waiting for pallet on transfer line');
		pause(0.5);
		
		
		
	end
end
			