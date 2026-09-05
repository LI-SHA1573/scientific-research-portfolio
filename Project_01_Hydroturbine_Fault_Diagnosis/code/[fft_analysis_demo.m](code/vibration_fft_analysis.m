%% FFT Analysis Demo for Vibration Signal
% This script demonstrates frequency-domain analysis
% of mechanical vibration signals using Fast Fourier Transform (FFT).
%
% Author: Sophia | Engineering Research
% Project: Hydroturbine Blade Fault Diagnosis


clc;
clear;
close all;


%% 1. Load vibration signal data
% Replace the filename with your own vibration dataset

data = readmatrix('vibration_signal.csv');


% Select vibration signal column
col = 1;

x = data(:, col);


%% 2. Data preprocessing

% Remove missing values
x = x(~isnan(x));


% Sampling frequency (Hz)
Fs = 5000;


% Remove DC component
% This avoids excessive amplitude at 0 Hz

x = x - mean(x);



%% 3. FFT calculation

% Signal length

N = length(x);


% Fast Fourier Transform

Y = fft(x);


% Two-sided spectrum

P2 = abs(Y/N);


% Single-sided spectrum

P1 = P2(1:floor(N/2)+1);


P1(2:end-1) = 2 * P1(2:end-1);



%% 4. Frequency axis

f = Fs*(0:floor(N/2))/N;



%% 5. Time-domain visualization

t = (0:N-1)/Fs;


figure;

plot(t,x,'LineWidth',1);

xlabel('Time (s)');

ylabel('Amplitude');

title('Time-domain Vibration Signal');

grid on;



%% 6. FFT spectrum visualization


figure;

plot(f,P1,'LineWidth',1.2);


xlim([0 100]);


xlabel('Frequency (Hz)');

ylabel('Amplitude');


title('FFT Spectrum of Vibration Signal');


grid on;



%% 7. Dominant frequency extraction

[pks,locs] = findpeaks(P1,f,...
    'MinPeakHeight',max(P1)*0.1,...
    'MinPeakDistance',5);



figure;

plot(f,P1,'LineWidth',1.2);

hold on;


plot(locs,pks,'ro',...
    'MarkerFaceColor','r');


for i = 1:length(locs)

    text(locs(i),pks(i),...
        sprintf('%.1f Hz',locs(i)),...
        'VerticalAlignment','bottom');

end


xlim([0 120]);


xlabel('Frequency (Hz)');

ylabel('Amplitude');


title('Dominant Frequency Components');


grid on;

