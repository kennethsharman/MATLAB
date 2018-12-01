acoustic_recording = 'C:\Users\kenne\OneDrive - University of Calgary\MATH 433\Essay\Audio\Electric\electric_high_a.wav';
[audio_in,fs]=audioread(acoustic_recording);
T0 = length(audio_in); % number of points of audio file
t = linspace(0,T0/fs, T0);

% Attack Phase
attack_region = find(t>0.14 & t<.166);
t_a = t(attack_region);
y_a = abs(audio_in(attack_region));
np_a = 13;
up_a = envelope(y_a,np_a,'peak');
up_a = abs(up_a);
%hold on; plot(t(attack_region), audio_in(attack_region)); 
%plot(t(attack_region), up_a); hold off

% % Decay/ Sustain/ Release Phase
dsr_region = find(t>=0.166 & t<4.5);
t_dsr = t(dsr_region);
y_dsr = audio_in(dsr_region);

np_dsr = 1000;
[up_dsr,lo_dsr] = envelope(y_dsr,np_dsr,'peak');
up_dsr = abs(up_dsr);
up_dsr(1:500) = up_dsr(500);
%hold on; plot(t(dsr_region), audio_in(dsr_region)); 
%plot(t(dsr_region), up_dsr); hold off

% Release Phase (r)
r_region = find(t>=4.5 & t<18); % release region data points
t_r = t(r_region); % release region data points
y_r = audio_in(r_region);
np_a = 3000;
[up_r,~] = envelope(y_r,np_a,'peak');
up_r = abs(up_r);
%up_r(1:500) = up_r(500); % Smooth transition at boundary

    % It was found that envelope produced a "bumpy" release so a
    % poloynomial was fit to represent average release
p=polyfit(t_r,up_r,4); % 3rd order polynomail found to give good fit
y_fit = polyval(p,t_r); % calc release vals of signal
%plot(t_r, audio_in(r_region), t_r, abs(y_fit))

% Combine Results
up = [up_a up_dsr y_fit];
t_vals = [t_a t_dsr t_r];
t_domain = find(t>0.14 & t<18); % time domain for recording waveform

figure; plot(t(t_domain), audio_in(t_domain), t_vals, up);
legend('Recording Waveform', 'Envelope');

up = up / max(up); % normalize envelope

duration=18; t=0:duration/(length(up)-1):duration;
signal = 0;
freqs = [60, 180, 219.9, 439.5, 659.7, 879.6, 1100, 1321, 1543, 1765, ...
    1987, 2211, 2436, 2658, 2886, 3086, 3307, 3343, 3569, 3752, 3801, ...
    4033, 4266, 4506, 4736, 4976, 5217, 5475, 5702, 5945, 6194, 6442, ...
    6702, 6948, 7200, 7460, 7723, 7994, 8264];
amps = 10^-5*[31.68, 15.02, 644.2, 733.8, 844, 473, 64.94, 202.3, ...
    303.7, 214.5, 100.2, 23.44, 22.16, 6.642, 11.1, 0.6545, 1.485, ...
    3.818, 1.57, 0.8938, 2.571, 3.071, 6.966, 4.334, 3.908, 0.6811, ...
    2.129, 0.7982, 1.553, 1.304, 0.5678, 0.1892, 0.2389, 0.7318, ...
    0.7335, 0.5695, 0.4744, 0.2393, 0.2715];
 
for n = 1:numel(freqs)
    signal = signal + amps(n) * sin(2*pi*freqs(n)*t);
end

%signal = signal / max(abs(signal));
signal = signal.*up;
signal = 0.6*signal / max(signal);

%figure; plot(t, signal);

elec_synth = 'C:\Users\kenne\OneDrive - University of Calgary\MATH 433\Essay\Audio\Electric\electric_synth.wav';
audiowrite(elec_synth,signal,fs);