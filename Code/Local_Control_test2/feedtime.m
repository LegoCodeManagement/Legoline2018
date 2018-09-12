function result = feedtime(dist,param1,param2,param3)
    switch dist
        case 'P'
            feed_time = param1;
        case 'N'
            feed_time = randraw('norm',[param1,param2],1);
        case 'R'
            feed_time = randraw('uniform',[param1,param2],1);
        case 'T'
            feed_time = randraw('tri',[param1,param2,param3],1);
        case 'E'
            feed_time = randraw('exp',(1/param1),1) + param2;
        otherwise 
            result = 10;
            disp('error selecting distribution. Periodic with 10s has been chosen as default')
            return;
    end
    if feed_time < 2
        disp(['feed time = ',num2str(feed_time),'s is too short (<2s). 10s has been chosen as default'])
        result = 10;
        return;
    end
    result = feed_time;
    return;
end