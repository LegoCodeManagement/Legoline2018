function result = movePalletToLightSensorU(motor, power, nxt, port, currentValue, timeOut, threshold)
%movePalletToLightSensor(motor, power, nxt, port, currentValue)
%Move the pallet until the light sensor detects it
%Return true if the function is completed within timeOut false otherwise
global wait
tic;
currentTime = toc;
movePallet = NXTMotor(motor, 'Power', power);
movePallet.SpeedRegulation = 0;
movePallet.SendToNXT(nxt);
while abs(GetLight(port, nxt) - currentValue) < threshold
    %{
    if (toc - currentTime > timeOut)
        disp('The light sensor hasnt detected the pallet before timeout');
        movePallet.Stop('off', nxt);
        result = false;
        return;
    end
    %}
    if wait.Data(1) == 49
		movePallet.Stop('off',nxt);
		while wait.Data(1) == 49
			pause(0.1);
		end
		movePallet.SendToNXT(nxt);
	end

    pause(0.1);
    
end
result = true;
pause(1);
movePallet.Stop('off', nxt);
end