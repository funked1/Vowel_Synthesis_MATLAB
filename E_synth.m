clear
clc

F0 = 100;        % Fundamental pitch frequency
Fs = 16000;      % Sampling frequency (samp/sec)
BW = 250;

ff1  = 150;             % first formant frequency
HPF1 = 200;      % high-pass cutoff frequency (Hz)
LPF1 = 100;      % low-pass cutoff frequency (Hz)

ff2  = 2690;            % second formant frequency
HPF2 = 2740;      % high-pass cutoff frequency (Hz)
LPF2 = 2640;      % low-pass cutoff frequency (Hz)

ff3  = 3450;            % third formant frequency
HPF3 = 3500;      % high-pass cutoff frequency (Hz)
LPF3 = 3400;      % low-pass cutoff frequency (Hz)

% Calculate Filter coefficients
[a11, a12] = Findfc(ff1, Fs, HPF1, LPF1);
[a21, a22] = Findfc(ff2, Fs, HPF2, LPF2);
[a31, a32] = Findfc(ff3, Fs, HPF3, LPF3);

% Generate 6th order transfer function
sos = [1 0 0 1, a11 a12; 1 0 0 1, a21 a22; 1 0 0 1, a31 a32];
[b, a] = sos2tf(sos)

% Generate glottcal pulse input signal
gp = GenGP(Fs, F0);

% Apply filter to input signal
output = filter(b, a, gp);

soundsc(gp, Fs)

%%% PLOTS %%%

% Plot Glottal Pulse
figure (1);
subplot 211
t= linspace(0, length(gp)/Fs, length(gp));
plot(t, gp)
xlabel('Time (sec)')
ylabel('Amplitude')
title('Glottal Pulse    ')

% Plot GLottal Pulse Train
subplot 212
t= linspace(0, ((1/F0) * 23), length(gp(Fs/F0: ((1/F0) * 23)*Fs)));
plot(t, gp(Fs/F0: ((1/F0) * 23)*Fs))
xlabel('Time (sec)')
ylabel('Amplitude')
title('Glottal Pulse Train    ')

% Plot Complete Glottal Pulse
figure(2)
t= linspace(0, Fs/2, length(gp)/2);
G= (abs(fft(gp)));
input=db(G(1: length(G)/2));
plot(t,input)
xlabel('Frequency (Hz)')
ylabel('Magnitude dB')
title('Complete Glottal Pulse    ')

% Plot output signal
figure(3)
t = linspace(0, Fs/2, length(output)/2);
o2 = (abs(fft(output)));
o3 = db(o2(1: length(output)/2));
plot(t, o3)
xlabel('Frequency (Hz)')
ylabel('Magnitude (db)')
title('Filter Modulated Glottal Pulse')