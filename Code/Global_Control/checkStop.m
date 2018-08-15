function result = checkStop
global fstatus;
if fstatus.Data(1) ~= 49
	result = true;
	return
end
result = false
return
end
