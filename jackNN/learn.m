clear
load monkeydata_training.mat

model = struct();
model.weights = rand(98,2);
fprintf('Training model...\n')
wdw = 200;
dirs = 1;
for I = 1:10
    fprintf(strcat('I:',num2str(I),'\n'))
for T = 1:90
    for D = 1:dirs
    inputs = transpose(g_filter(trial(T,D).spikes,wdw,5));
    targets = tanh(transpose(trial(T,D).handPos(1:2,:))./100);
    model = train(model,inputs,targets);
    end
end
end
fprintf('Testing model...\n')
figure
for T = 91:100
    for D = 1:dirs
        switch D
                case 1
                    C = 'y';
                case 2
                    C = 'm';
                case 3
                    C = 'c';
                case 4
                    C = 'r';
                case 5
                    C = 'g';
                case 6
                    C = 'b';
                case 7
                    C = 'w';
                case 8
                    C = 'k';
                otherwise
                    C = 'k';
            end
        inputs = transpose(g_filter(trial(T,D).spikes,wdw,5));
        outputs = predict(model,inputs);
        plot(atanh(outputs(:,1)),atanh(outputs(:,2)),C)
        set(gca,'Color',[0.8 0.8 0.8]);
        hold on
    end
end


