function [a1, a2] = Findfc(form_f, Fs, HPF, LPF)
    omega = NormFreq(form_f, Fs);
    Bw = LPF - HPF;
    k = (-pi * Bw) / Fs;
    r = exp(k);
    a1 = (-2 * r * cos(omega));
    a2 = (r * r);
end