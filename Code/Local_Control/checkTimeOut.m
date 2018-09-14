function result = checkTimeout(timeOut)
result = true;
if toc > timeOut
        disp('The pallet hasnt left before time out');
        result = false;
        return;
    end
return
end
