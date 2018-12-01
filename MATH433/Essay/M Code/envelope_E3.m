E3_Recording = 'C:\Users\kenne\OneDrive - University of Calgary\MATH 433\Essay\Audio\Recordings\E4_Tuning_Fork\E4_Tuning_Fork_Recording.wav';
[audio_in,fs]=audioread(E3_Recording); % Tuning Fork Recording
T0 = length(audio_in); % number of points of audio file
t = linspace(0,T0/fs, T0);
t_domain = find(t>0.04 & t<4);

hs = abs(hilbert(audio_in(t_domain)));

p=polyfit(t(t_domain),hs,50);
x1 = linspace(0,5);
y1 = polyval(p,x1);

hold on
plot(t(t_domain),audio_in(t_domain))
plot(t(t_domain),hs)
plot(t(t_domain),-hs)

L = length(x1); range = 2:L-20;
plot(x1(range),y1(range), 'linewidth',1.5); % poly fit
plot(x1(range),-y1(range), 'linewidth',1.5); % poly fit
%legend('Audio Waveform','Upper Envelope','Lower Envelope', 'PolyFit')
%legend('Audio Waveform','PolyFit')
axis([0,4.2,-0.1,0.1])
hold off