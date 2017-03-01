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

