N = 39; % Number of harmonics
t = linspace(0,5*pi,500); % t-vals
f = zeros(1,500); % f(t)-vals

% for i=1,3,5,7...,N
for n = 1:2:N
    b = 4.0/(pi*n); % calc coefficient
    f = f + b*sin(n*t); % add harmonic to soln 
end

plot(t,f)
