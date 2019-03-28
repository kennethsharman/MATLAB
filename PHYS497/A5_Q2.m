fs = 4096;          % Sample frequency (Hz)
n = 4096;           % Number of samples
t = (0:(n-1))/fs;   % Create time vector

% Create timeseries
x = cos(2*pi*t) + cos(2*pi*10*t) + cos(2*pi*20*t) + cos(2*pi*100*t);

% Take Fourier Transform
y = fft(x);             % Discrete Fourier Transform
f = (0:n-1)*(fs/n);     % Construct frequency axis

% Plot timeseries
figure(1); plot(t,x,'r')
xlabel('Time (s)'); ylabel('Signal'); title('{\bf Time Series}')

% Plot DFT real
figure(2); subplot(2,1,1)
plot(f(1:n/2+1),real(y(1:n/2+1)))
xlabel('Frequency (Hz)'); ylabel('Re(DFT)')
xlim([-1 110]); ylim([-500 2500])
title('Fourier transform: real part')
hold;
% Plot DFT imaginary
subplot(2,1,2); plot(f(1:n/2+1),imag(y(1:n/2+1)))
xlabel('Frequency (Hz)'); ylabel('Im(DFT)')
title('Fourier transform: imaginary part')
hold off

% Lo Pass Filter - 1/2 Power f > 10 Hz
y(11:4096) = y(11:4096) * 0.707;

% Plot Filtered DFT - real
figure(3); subplot(2,1,1)
plot(f(1:n/2+1),real(y(1:n/2+1)))
xlabel('Frequency (Hz)'); ylabel('Re(DFT)')
xlim([-1 110]); ylim([-500 2500])
title('Fourier transform: real part')
hold;
% Plot Filtered DFT - imaginary
subplot(2,1,2); plot(f(1:n/2+1),imag(y(1:n/2+1)))
xlabel('Frequency (Hz)'); ylabel('Im(DFT)')
title('Fourier transform: imaginary part')
hold off

% Inverse DFT
x2 = ifft(y);

% Plot filtered AND unfiltered timeseries
figure(4); plot(t, x, 'b'); hold on
plot(t,x2,'r'); hold off
ylim([-3,4])
xlabel('Time (s)'); ylabel('Signal')
title('{\bf Filtered and Unfiltered Time Series}')
legend('Unfiltered', 'Filtered')
