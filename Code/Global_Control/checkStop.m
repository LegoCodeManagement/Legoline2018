function result = checkStop
%checks to see if Legoline has been stopped by user
global fstatus;
if (fstatus.Data(1) ~= 49)
	result = false;
	return
end
result = true;
return
end
