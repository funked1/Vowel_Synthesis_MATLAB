function [glottal] = GenGP(fs, f0)
    % Glottal Pulse Limits
    N1 = round(0.0025 * fs);
    N3 = round(0.003 * fs);
    N2 = N3 - N1;
    
    % Create Glottal Pulse
    glot = zeros(1, N3);
    for i = 1:N1
        glot(i) = 0.5 * (1 - cos((pi * i)/N1));
    end
    for i = N1 + 1 : N3
        glot(i) = cos(pi * (i - N1) / (2 * N2));
    end
    
    % zero pad glot signal
    pad= zeros(size(glot));
    glot= cat(2, pad, cat(2, glot, pad));
    
    % Creates a Pulse Train
    pulse= zeros(1, 1*fs);
    for i= 1: length(pulse)
        if mod(i, f0) == 0
            pulse(i)= 1;
        end
    end
    
    % Creates complete glottal signal
    glottal= conv(glot, pulse);
    noise= randn(size(glottal));
    noise= noise ./ (10*max(abs(noise)));
    glottal= glottal + noise;
end
