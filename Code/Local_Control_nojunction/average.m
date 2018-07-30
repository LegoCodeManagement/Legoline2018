function result = average(nxt, port)

a1 = GetLight(port, nxt);
pause(0.1);
a2 = GetLight(port, nxt);
pause(0.1);
a3 = GetLight(port, nxt);
pause(0.1);
a4 = GetLight(port, nxt);

result = 0.25*(a1+a2+a3+a4);
end