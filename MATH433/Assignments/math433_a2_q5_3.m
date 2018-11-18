N = 39; % Number of harmonics
t = linspace(0,5*pi,500); % t-vals
g = zeros(1,500); % g(t) = df/dt

for n = 1:2:N
    b = 4.0/pi;
    g = g + n*cos(n*t);
end

plot(t,g)