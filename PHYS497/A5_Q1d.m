fs = 100;               % Sample frequency (Hz)
n = 128;                % Number of samples
t = (0:(n-1))/fs;       % Create time vector
x = sin(2*pi*51*t);     % Create timeseries
 
% Take Fourier Transform
y = fft(x);             % Discrete Fourier Transform
f = (0:n-1)*(fs/n);     % Construct frequency axis

% Display max value, index, and corresponding frequency
[maxval,index] = max(abs(y));
disp(y(index))
fprintf('index = %1.f\nf = %1.4f\n', index-1, f(index))

%Plot
subplot(3,1,1)
stem(t,x,'filled')
hold on
plot(t,x,'r')
xlabel('Time (s)'); ylabel('Signal')
title('{\bf Time Series}')
hold off
subplot(3,1,2) 
stem(f(1:n/2+1),real(y(1:n/2+1)),'filled') 
xlabel('Frequency (Hz)')
ylabel('Re(DFT)'); ylim([-10 10])
title('Fourier transform: real part') 
subplot(3,1,3) 
stem(f(1:n/2+1),imag(y(1:n/2+1)),'filled') 
xlabel('Frequency (Hz)'); ylabel('Im(DFT)')
title('Fourier transform: imaginary part')
