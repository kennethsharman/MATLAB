E3_Recording = 'C:\Users\kenne\OneDrive - University of Calgary\MATH 433\Essay\Audio\E4_Tuning_Fork\E4_Tuning_Fork_Recording.wav';
[audio_in,fs]=audioread(E3_Recording);
T0 = length(audio_in); % number of points of audio file
t = linspace(0,T0/fs, T0);
audio_fft = fft(audio_in, T0); % compute fft of audio file

figure; subplot(1,2,1) % first plot
t_domain = find(t>0.04 & t<0.08); % time domain for plot
plot(t(t_domain),audio_in(t_domain)); 
title('Waveform of E3'); xlabel('Time(s)'); ylabel('Amplitude')
 
subplot(1,2,2) % second plot
amplitude = 2*abs(audio_fft(1:T0/2+1))/T0; % normlaized mag of rhs of fft
frequency = fs/2*linspace(0,1,T0/2+1); % nyquist frequency

[pks,locs] = findpeaks(amplitude);

subplot(1,2,2) % first plot
%plot(frequency,mag2db(amplitude), pks, locs, 'or');
plot(frequency,amplitude);
axis([0 600 0 5*10^-2]); yticks(linspace(0,5*10^-2,5));
title('FFT of E3'); xlabel('Frequency(Hz)'); ylabel('Amplitude')
