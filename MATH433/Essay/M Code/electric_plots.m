acoustic_recording = 'C:\Users\kenne\OneDrive - University of Calgary\MATH 433\Essay\Audio\Electric\electric_high_a.wav';
[audio_in,fs]=audioread(acoustic_recording);
t = linspace(0,length(audio_in)/fs, length(audio_in));
T0 = length(audio_in); % number of points of audio file

% Waveform Plot
figure; subplot(1,2,1) % first plot
t_domain = find(t>0 & t<13.0); % time domain for plot
plot(t(t_domain),audio_in(t_domain)); 
xlabel('Time(s)'); ylabel('Amplitude')
title('Electric A3 Waveform')

subplot(1,2,2) % second plot
t_domain = find(t>0.16 & t<.195); % time domain for plot
plot(t(t_domain),audio_in(t_domain));
xlabel('Time(s)'); ylabel('Amplitude')
title('Magnified View of Electric A3 Waveform')

% Frequency Plot
figure;
audio_fft = fft(audio_in, T0); % compute fft of audio file
amplitude = 2*abs(audio_fft(1:T0/2+1))/T0; % magnitude of rhs of fft
%amplitude = amplitude / max(amplitude)
frequency = fs/2*linspace(0,1,T0/2+1); % nyquist frequency

plot(frequency,amplitude)
axis([0 2400 0 10^-2]); xticks(linspace(200,2400,12));
xlabel('Frequency (Hz)'); ylabel('Amplitude ()');