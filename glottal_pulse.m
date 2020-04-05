clear
close
clc

fs = 16000;     % Sampling frequency in Hz
f0 = 130;       % Fundamental Frequency in Hz

% glot Pulse Limits
N1 = round(0.0025 * fs);
N3 = round(0.003 * fs);
N2 = N3 - N1;

% Create glot Pulse
glot = zeros(1, N3);
for i = 1:N1
    glot(i) = 0.5 * (1 - cos((pi * i)/N1));
end
for i = N1 + 1 : N3
    glot(i) = cos(pi * (i - N1) / (2 * N2));
end

% Creates a Pulse Train
pulse= zeros(1, 1*fs)
for i= 1: length(pulse)
    if mod(i, f0) == 0
        pulse(i)= 1;
    end
end

% Creates complete glot signal
glot= conv(glot, pulse);
noise= randn(size(glot));
noise= noise ./ (10*max(abs(noise)));
glot= glot + noise;soundsc(glot,16000);

% Plot Glottal Pulse
figure (1);
subplot 211
t= linspace(0, length(glot)/fs, length(glot));
plot(t, glot)
xlabel('Time (sec)')
ylabel('Amplitude')
title('Glottal Pulse    ')