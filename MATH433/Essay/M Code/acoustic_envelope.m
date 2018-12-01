function signal_envelope=acoustic_envelope(t,audio_in)
% Function is customized for acoustic_high_a.wav recording.
% Divides signal into Attack, Decay/ Sustain, and Release section for which
% an envelope is determined and returned. The samples/interval are different
% each section to provide best possible envelope fit.
% Paramters
%   audio_in:   acoustic_high_a.wav signal
%   t:          time values

% Attack Phase (a)
attack_region = t>=0.0 & t<.165; % attack region data points
y_a = abs(audio_in(attack_region)); % attack region signal
np_a = 100; % number of samples per interval
[up_a,~] = envelope(y_a,np_a,'peak'); % only upper envelope is considered
up_a = abs(up_a); % pretend any negative values didn't happen

% Decay/ Sustain (ds)
ds_region = t>=0.165 & t<5; % ds region data points
y_ds = audio_in(ds_region);
np_a = 2000;
[up_ds,~] = envelope(y_ds,np_a,'peak');
up_ds = abs(up_ds);

% Release Phase (r)
r_region = t>=5 & t<=8; % release region data points
t_r = t(r_region); % release region data points
y_r = audio_in(r_region);
np_a = 3000;
[up_r,~] = envelope(y_r,np_a,'peak');
up_r = abs(up_r);
up_r(1:500) = up_r(500); % Smooth transition at boundary

    % It was found that envelope produced a "bumpy" release so a
    % poloynomial was fit to represent average release
p=polyfit(t_r,up_r,3); % 3rd order polynomail found to give good fit
y_fit = polyval(p,t_r); % calc release vals of signal

% Combine Results
up = [up_a up_ds y_fit]; % concat each section of signal envelope

signal_envelope = up; % return envelope