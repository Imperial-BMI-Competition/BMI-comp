function [l_PSTH_non_shifted,l_PSTH_shifted,l_local_shifted, shifted_signal,Av_po] = fr_processing(trial,dt)

l_PSTH_shifted = cell(98,8); 
l_PSTH_non_shifted = cell(98,8); 
l_local_shifted = cell(98,8); 
shifted_signal = cell(98,8); 

for n=1:size(trial,1)
    for a = 1:size(trial,2)
        for u = 1:size(trial(1,1).spikes,1)
    sizes_recordings(u,n,a) = length(trial(n,a).spikes(u,:));
        end 
    end 
end 


for i = 1:size(trial(1,1).spikes,1)
     for a = 1:size(trial,2)

l_PSTH_non_shifted{i,a} = zeros(1, max(max(max(sizes_recordings(:,:,:))))); 

A = zeros(1,max(max(max(sizes_recordings(:,:,:)))));
B = zeros(1,max(max(max(sizes_recordings(:,:,:)))));

         
closest_trial = findFirstOnset(trial,i,a);
l_local_shifted{i,a} = zeros(size(trial,1), max(max(max(sizes_recordings(:,:,:)))));
shifted_signal{i,a} = zeros(size(trial,1), max(max(max(sizes_recordings(:,:,:)))));

for n = 1:size(trial,1)
    

len = length(trial(n,a).spikes(i,:));

[new_shift] = shift_xcorr(trial(closest_trial,a).spikes(i,:),trial(n,a).spikes(i,:),2); %shift by best shift to max cross corr

A(1:len) = A(1:len) + new_shift;
B(1:len) = B(1:len) + trial(n,a).spikes(i,:);


l_local_shifted{i,a}(n,1:length(fr_es(new_shift,dt))) = fr_es(new_shift,dt);

shifted_signal{i,a}(n,1:length(new_shift)) = new_shift; 

B(1:len) = B(1:len) + trial(n,a).spikes(i,:);

end 

l_PSTH_shifted{i,a} = fr_es(A,dt);
l_PSTH_non_shifted{i,a} = fr_es(B,dt);


     end 
end 


Av_po = cell(1,8);

    for angle = 1:8
Av_po{angle} = zeros(3,max(max(max(sizes_recordings(:,:,:)))));
        for n = 1:100
            
Av_po{angle}(:,1:size(trial(n,angle).handPos,2)) = Av_po{angle}(:,1:size(trial(n,angle).handPos,2)) + trial(n,angle).handPos;

        end 
        Av_po{angle} = Av_po{angle}./100;
    end 


end

