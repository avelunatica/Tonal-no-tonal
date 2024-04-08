function [tone]=identificarTonal2(audio,Nfft)

%Fuction to identify the signals as tonals or non tonals
%
% Input parameters:
%   audio= data
%   Nfft= length of the window
%
%Output parameters:
%tone: True if the audio is tonal or on the contrary, non tonal

%ver_espectro function modified. It makes all the coding from the original
%one but removed the switch to choose different windows and the plotting

[signal,fs]=audioread(audio);
signal = signal(:,1);
Ny=length(signal); 
Ts=1/fs;
t=0:Ts:Ts*(Ny - 1);
fss=[];
window=hamming(Nfft);
window=window/sum(window);
columnas=ceil(Ny/Nfft);
totals=columnas*Nfft;
if totals > Ny
    s0=[signal; zeros(totals-Ny,1)];
else
    s0=signal;
end
ss=reshape(s0,Nfft,columnas);

for indc=1:columnas
    wseg1=ss(:,indc).*window;
    fss=[fss abs(fft(wseg1,Nfft))]; 
end
nfss=fss(1:Nfft/2+1,:);
y=mean(nfss,2);
f=0:fs/Nfft:fs/2;

% Code I added. We smooth the signal (lots of peaks we don't want). Then I
% search for all the peaks that are upper than the Media and we store '1'
% if it founds one. Then with an if we decide if tonal or non tonal.

y = smoothdata(y);
y = smoothdata(y);
M = mean(y);
TF = islocalmax(y,'MinProminence',M);
number_of_tones=sum(TF(:) == 1);

if number_of_tones==0
    tone="Falso";
else
    tone="Verdadero";
end
end