function [decodedPosX, decodedPosY] = positionEstimator(data_test, Models,D)
model = Models{D};
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
wdw = 100;
sigma = 20;
X = con2seq(g_filter(data_test.spikes,wdw,sigma));
[Xs,Xi,Ai,~] = preparets(model.net,X);
Dpos = seq2con(model.net(Xs,Xi,Ai));
DposC = sum(Dpos{:},2);
decodedPosX = DposC(1) + model.x0;
decodedPosY = DposC(2) + model.y0;
end


