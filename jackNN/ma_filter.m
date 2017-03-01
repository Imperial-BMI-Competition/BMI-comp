function ma_spikes = ma_filter(spikes, wdw)
% computes moving average for each unit in a set of 98 spike trains
% spikes = spike trains
% wdw = moving average window
ma_spikes = zeros(size(spikes));
for unit = 1:size(spikes,1)
   for t = wdw:size(spikes,2)
       ma_spikes(unit,t)=sum(spikes(unit,t-wdw+1:t))/wdw;
   end
end
end

