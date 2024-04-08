function [tone] = identificarTonal(audio)

%Fuction to identify the signals as tonals or non tonals
%
% Input parameters:
%   audio= data
%
%Output parameters:
%tone: True if the audio is tonal or on the contrary, non tonal


[signal, fs]=audioread(audio);
signal=signal(:, 1); %only mono, not stereo
Nsenal=length(signal);  %Total samples of the signal
Ts=1/fs;
t=0:Ts:Ts*(Nsenal - 1);

ffx=fft(signal, fs);%fft with fs points
ffx=abs(ffx); %Amplitude
fx=ffx(1:fs/2+1); %Part of interest
f=(0:fs/2); %Frequency axis

% figure;
% Lpf=20*log10(abs(fx)/2e-5);
% plot(f(1:250),Lpf(1:250));xlabel('Frequency (Hz)'), ylabel('Power Spectrum (dB)');
% set(gca,'FontSize',16);
% title("FFT "+audio);

M=mean(fx); %inferior threeshold
y=smoothdata(fx);
y=smoothdata(y);

maxs=islocalmax(y,'MinProminence',M);
number_of_tones=sum(maxs(:)==1);


if number_of_tones<=1                                                      
    tone="False";
else
    tone="True";
end