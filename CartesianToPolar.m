i = 1;
j = 1;
%for j = 2:8
j = 2
for i = 1:100
    positions = trial(i,j).handPos;
    [theta, rho] = cart2pol(positions(1,:),positions(2,:));
    trial(i,j).handPosPolar = [theta; rho]
end
%end


subplot(2,1,1)
plot(rad2deg(theta));
subplot(2,1,2)
plot((rho));
figure
%%
j = 1;

allthetas = zeros(100,1000);
allangles = zeros(100,1000);
%%
[peakref locsref] = max(trial(1,j).handPosPolar(1,:));

%% Find the earliest firing neuron
templocref = 1000000;
temvar = 3;
for k = 1:100
    [peakreftemp locsreftemp] = max(trial(k,j).handPosPolar(1,:));
    if  locsreftemp(1)<locsref
        tempk = k
    end
end

[peakref locsref] = max(trial(tempk,j).handPosPolar(1,:));


%%
for i = 1:100
    %for j = 1:8
    [peak locs] = max(trial(i,j).handPosPolar(1,:));
    diff = locsref(1)-locs(1)+1
    
    ShiftedSpikes =  circshift(trial(i,j).spikes,diff);
    
    currenttrial = trial(i,j).handPosPolar(1,:);
    currenttrial =   circshift(currenttrial, diff);
    allthetas(i,:) = [currenttrial(1,:), zeros(1,length(allthetas)-length(currenttrial(1,:)))];
    
    currenttrialangle = trial(i,j).handPosPolar(2,:);
    currenttrialangle =   circshift(currenttrialangle, diff);
    allangles(i,:) = [currenttrialangle(1,:), zeros(1,length(allthetas)-length(currenttrialangle(1,:)))];
    
    %{
    % end
    subplot(2,1,1)
    plot(rad2deg(allthetas(i,:)));
    subplot(2,1,2)
    plot((allangles(i,:)));
    pause
    %}
end

%plot(allangles, allthetas)
%pause


averagedthetas = mean(allthetas);
averagedangles = mean(allangles);

subplot(2,1,1)
plot(rad2deg(averagedthetas));
subplot(2,1,2)
plot((averagedangles));



