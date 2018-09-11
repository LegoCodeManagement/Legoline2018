function result = checkTimeout(timeOut)
%checks to see if timeout has been exceeded
if toc > timeOut
        disp('The pallet hasnt left before time out');
        result = false;
        return;
    end

end
