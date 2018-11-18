N = 39; % Number of harmonics
t = linspace(0,5*pi,500); % t-vals
w = zeros(1,500); % w(t)-vals
w = w + (pi/2); % add a_0 = pi/2

% for i=1,3,5,7...,N
for n = 1:2:N
    a_n = (2/(pi*n^2))*(cos(n*pi)-1) % calc coef
    w = w + a_n*cos(n*t); % add harmonic to soln 
end

plot(t,w)