function model = positionEstimatorTraining(data_train)
% Template for our training function for the model
% Inputs: trainingData (trials)
% Outputs: modelParameters (Parameters of our regression model, can be anything we choose)
% ---
function output = g_filter(spikes, wdw, sigma)
output = zeros(size(spikes));
    for n = 1:size(spikes,1)
        a = 1/(sigma*sqrt(2*pi));
        x = -(wdw-1)/2:(wdw-1)/2;
        g = a*exp(-(x.^2)./(2*sigma^2)); 
        g_spikes = conv(spikes(n,:),g);
        output(n,:) = g_spikes(wdw/2:end-wdw/2);
    end
end
model = struct();
model.x0 = data_train(1,1).handPos(1,1);
model.y0 = data_train(1,1).handPos(2,1);
hidden = 8;
delays = 1;
wdw = 400;
sigma = 100;
net = layrecnet(1:delays,hidden,'traingdx');
net.trainParam.showWindow = 1;
net.performParam.normalization = 'percent';
%% Training
for N = 1:size(data_train,1)
    for D = 1:size(data_train,2)
        index = (N-1)*size(data_train,2) + D;
        rawInput = g_filter(data_train(N,D).spikes,wdw,sigma);
        rawInput(:,end+1:1000) = NaN;
        X{1,index} = rawInput;
        rawTarget = diff(data_train(N,D).handPos(1:2,:),1,2);
        rawTarget(:,end+1) = 0;
        rawTarget(:,end+1:1000) = NaN;
        T{1,index} = rawTarget;
    end
end
[Xs,Xi,Ai,Ts] = preparets(net,X,T);
model.net = train(net,Xs,Ts,Xi,Ai);
pause(0.5)
close all
end

