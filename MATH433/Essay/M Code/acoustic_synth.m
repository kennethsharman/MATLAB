acoustic_recording = 'C:\Users\kenne\OneDrive - University of Calgary\MATH 433\Essay\Audio\Acoustic\acoustic_high_a.wav'
synth_acoustic = 'C:\Users\kenne\OneDrive - University of Calgary\MATH 433\Essay\Audio\Acoustic\acoustic_synth.wav';

[audio_in,fs]=audioread(acoustic_recording); % read file
T0 = length(audio_in); % number of points of audio file
t = linspace(0,T0/fs, T0); % independent variable

envelope = acoustic_envelope(t,audio_in); % determine envelope of signal

duration=8; % set duration to match guitar recording
signal = 0; % declare output signal variable

% all frequencies observed in acoustic frequency spectrum
freqs = [96.13, 146.1, 168.6, 220.3, 440.3, 660.5, 880.5, 1101, 1322, ...
    1542, 1764, 1985, 2207, 2429, 2652, 2874, 3098, 3320, 3546, 3770, ...
    3996, 4221, 4448, 4673, 5130, 5304, 5361, 5593, 5824, 6055, 6282, ...
    6983, 7223, 7465, 7703, 8219, 8669, 9154, 9666];

% ampltidues of frequencies observed in acoustic frequency spectrum
amps = 10^-5*[148.3, 94.8, 75.39, 1060, 871.8, 424.7, 289.4, 423.8, ...
    47.66, 9.8, 8.847, 33.23, 40.71, 44.17, 28.09, 36.37, 5.377, 1.189, ...
    10.5, 13.75, 10.12, 6.331, 8.902, 6.686, 2.227, 14.27, 4.743, 2.52, ...
    0.8555, 1.816, 0.9218, 0.5397, 0.3872, 0.3638, 0.6866, 0.4186, ...
    0.4894, 0.3214, 0.4163];
% add A*sin(2pi*v*t) for all frequencies, v
for n = 1:numel(freqs)
    signal = signal + amps(n) * sin(2*pi*freqs(n)*t);
end

signal = signal.*envelope; % element-wise multiplication of signal & envelope
signal = signal / max(signal); % normalize Signal

audiowrite(synth_acoustic,signal,fs); % write signal to WAV file

%figure; plot(t,audio_in,t,envelope); legend('Recording Waveform','Envelope');
%t=0:duration/(length(envelope)-1):duration;