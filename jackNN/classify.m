load monkeydata_training.mat

model = struct();
model.weights = rand(98,8);

total_error = zeros(1,100);
for T = 1:100
    error_array = zeros(1,8);
    for D = 1:8
        inputs = ma_filter(trial(T,D).spikes(:,1:300),70)';
        targets = zeros(300,8);
        targets(:,D) = 1;
        [model, error] = train_model(model, inputs, targets);
        error_array(D) = mean2(error);
    end
    total_error(T) = log(mean(error_array));
    pause(0.1)
    plot(1:T,total_error(1:T))
    hold on
end
%% Test
T = randi(100)
D = randi(8)
inputs = trial(T,D).spikes(:,1:300)';
targets = zeros(300,8);
targets(:,D) = 1;
outputs = predict(model,inputs);
pause(0.05)
