[pks,locs] = findpeaks(y4,'MinPeakProminence',10);
plot(x(locs),pks,'.',x,y4)
x6 = x(locs);
