function dibujarGraficas (signal,fs,i,audios)

% Void function to plot the audios and their spectrum
%
% Input parameters:
% signal=data
% fs= sampling frequency
%i = we need it to get the audio we want to plot
%audios= signal array
%Output parameters:
% none


signal=signal(:, 1);
Nsignal=length(signal);  %Total samples of the signal
Ts=1/fs;
t=0:Ts:Ts*(Nsignal - 1);

figure
subplot(2,1,1);
plot(t,signal), xlabel('Time (s)'), ylabel('Amplitude (Pa)'), axis tight;
set(gca,'FontSize',16);
title("Audio "+audios{i});

%Plotting the power spectrum density.
%pow2db plot the PSD of the signal using log axis 

[pxx,f] = pspectrum(signal,fs);
subplot(212), plot(f,pow2db(pxx)), xlabel('Frequency (Hz)'), ylabel('Power Spectrum (dB)');
set(gca,'FontSize',16);
title("PSD "+ audios{i});
grid;

end