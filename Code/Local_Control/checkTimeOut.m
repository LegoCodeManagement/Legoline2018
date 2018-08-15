function result = checkTimeout(timeOut)

if toc > timeOut
        disp('The pallet hasnt left before time out');
        result = false;
        return;
    end

end
