n=1e3;
y=ones(n,1);
for i = 1:1:n
    tic
    pause(randraw('exp',100,1));
    y(i) = toc;
end
