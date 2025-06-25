x = -5:0.1:5;
z = 5*x.^2 + 3*(x + 3*1.^2);
plot(z);
[x, f, m, n, k, v] = ga(@(x) 5*x(1).^2 + 3*(x(1) + 3*1.^2), 1); %NAREDBA ZA POKRETANJE
grid ON