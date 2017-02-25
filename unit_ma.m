function ma_spikes = unit_ma(spikes, wdw)
ma_spikes = zeros(size(spikes));
for unit = 1:size(spikes,1)
   for t = wdw:size(spikes,2)
       ma_spikes(unit,t)=sum(spikes(unit,t-wdw+1:t))/wdw;
   end
end
end

