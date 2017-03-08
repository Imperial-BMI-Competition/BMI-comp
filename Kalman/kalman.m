
clear all; 
close all;
fprintf('Loading data...\n')
load('monkeydata_training.mat');


%x=[x y]
%?t = 20ms
%zk =Hkxk +qk, (zk - firing rate 
%C = 98 cells

dt = 20; 
trial = cart2polar(trial,true);
output = fr_processing(trial,20);

%% angle 1 learning
%for angle 1

kalmans = trainKalman(output);

%% 
for t = 1:100
for i = 1:98
z(i,:) = smooth(output.l_local_non_shifted{i,a}(t,:),1000);
end

angle = 1; 

% xhat = predictKalman(kalmans,angle,kalmans{angle}.Z);
xhat = predictKalman(kalmans,angle,z);


% figure 
% plot(xhat(1,:),xhat(2,:))
% hold on 
% plot(trial(t,a).handPos(1,:),trial(t,a).handPos(2,:))

err(t) = sqrt(immse(trial(t,a).handPos(1:2,:),xhat(1:2,1:length(trial(t,a).handPos))));
end 