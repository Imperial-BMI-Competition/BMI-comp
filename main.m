% BMI competition main file
% Jonathan Campbell, Alexander Camuto, Enrico Tosoratti, Amna Askari

load('monkeydata_training.mat')

%% Smoothing test

test_spikes = trial(1,1).spikes;

ma_spikes = unit_ma(test_spikes,31100);

area(ma_spikes(1,:))


%% Convolution

%% Fourier

%% Adaptive filter