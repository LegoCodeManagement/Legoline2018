function result = checkStop
global fstatus;
if (fstatus.Data(1) ~= 49)
	result = false;
	return
end
result = true;
return
end
