% shows all trajectories in XY coloured by their direction
load('monkeydata_training.mat')
figure
for D = 1:size(trial,2)
    for T = 1:size(trial,1)
        X = trial(T,D).handPos(1,:);
        Y = trial(T,D).handPos(2,:);
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
        plot(X,Y,C)
        set(gca,'Color',[0.8 0.8 0.8]);
        hold on
    end
end