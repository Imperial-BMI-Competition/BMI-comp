function output = fr_processing(trial,dt)

output = struct();

output.l_PSTH_non_shifted = cell(98,8);
output.l_PSTH_shifted = cell(98,8);
output.shifted_signal = cell(98,8);
output.l_local_shifted = cell(98,8);
output.Av_po = cell(1,8);


for n=1:size(trial,1)
    for a = 1:size(trial,2)
        for u = 1:size(trial(1,1).spikes,1)
    sizes_recordings(u,n,a) = length(trial(n,a).spikes(u,:));
        end 
    end 
end 


for i = 1:size(trial(1,1).spikes,1)
     for a = 1:size(trial,2)

output.l_PSTH_non_shifted{i,a} = zeros(1, max(max(max(sizes_recordings(:,:,:))))); 

A = zeros(1,max(max(max(sizes_recordings(:,:,:)))));
B = zeros(1,max(max(max(sizes_recordings(:,:,:)))));

         
closest_trial = findFirstOnset(trial,i,a);
output.l_local_shifted{i,a} = zeros(size(trial,1), max(max(max(sizes_recordings(:,:,:)))));
output.shifted_signal{i,a} = zeros(size(trial,1), max(max(max(sizes_recordings(:,:,:)))));

for n = 1:size(trial,1)
    

len = length(trial(n,a).spikes(i,:));

[new_shift] = shift_xcorr(trial(closest_trial,a).spikes(i,:),trial(n,a).spikes(i,:),2); %shift by best shift to max cross corr

A(1:len) = A(1:len) + new_shift;
B(1:len) = B(1:len) + trial(n,a).spikes(i,:);


output.l_local_shifted{i,a}(n,1:length(fr_es(new_shift,dt))) = fr_es(new_shift,dt);

output.shifted_signal{i,a}(n,1:length(new_shift)) = new_shift; 

B(1:len) = B(1:len) + trial(n,a).spikes(i,:);

end 

output.l_PSTH_shifted{i,a} = fr_es(A,dt);
output.l_PSTH_non_shifted{i,a} = fr_es(B,dt);


     end 
end 



    for angle = 1:8
output.Av_po{angle} = zeros(3,max(max(max(sizes_recordings(:,:,:)))));
        for n = 1:100
            
output.Av_po{angle}(:,1:size(trial(n,angle).handPos,2)) = output.Av_po{angle}(:,1:size(trial(n,angle).handPos,2)) + trial(n,angle).handPos;

        end 
        output.Av_po{angle} = output.Av_po{angle}./100;
    end 


end

