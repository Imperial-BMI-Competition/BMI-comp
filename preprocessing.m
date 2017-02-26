% BMI competition main file


load('monkeydata_training.mat')

%% Smoothing test

test_spikes = trial(1,1).spikes;

ma_spikes = unit_ma(test_spikes,10);
figure(1)
for i = 1:98
    area(ma_spikes(i,:))
    pause
end
%% Convolution

%% Fourier

%% Adaptive filter