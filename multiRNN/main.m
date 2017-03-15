RMSE = [];

% Jonathan Campbell, Alexander Camuto, Enrico Tosoratti, Amna Askari

% (try not to edit this file too much - based off the file
% testFunction_for_students_MTb(1).m which assesses the performance of the
% model)


%% Continuous Position Estimator Test Script
% This function first calls the function "positionEstimatorTraining" to get
% the relevant modelParameters, and then calls the function
% "positionEstimator" to decode the trajectory.

close all
load monkeydata_training.mat

% Set random number generator
rng(14353);
ix = randperm(length(trial));

% Select training and testing data (you can choose to split your data in a different way if you wish)
trainingData = trial(ix(1:90),:);
testData = trial(ix(91:end),:);



meanSqError = 0;
n_predictions = 0;  

figure
hold on
axis square
grid

% Train Model
fprintf('Training the continuous position estimator...')
modelParameters = positionEstimatorTraining(trainingData);

%% Test model
fprintf('Testing the continuous position estimator...')
for tr=1:size(testData,1)
    display(['Decoding block ',num2str(tr),' out of ',num2str(size(testData,1))]);
    pause(0.001)
    for direc=randperm(8)
        decodedHandPos = [];

        times=320:20:size(testData(tr,direc).spikes,2);
        
        for t=times
            past_current_trial.trialId = testData(tr,direc).trialId;
            past_current_trial.spikes = testData(tr,direc).spikes(:,1:t); 
            past_current_trial.decodedHandPos = decodedHandPos;

            past_current_trial.startHandPos = testData(tr,direc).handPos(1:2,1); 
            
            if nargout('positionEstimator') == 3
                [decodedPosX, decodedPosY, newParameters] = positionEstimator(past_current_trial, modelParameters);
                modelParameters = newParameters;
            elseif nargout('positionEstimator') == 2
                [decodedPosX, decodedPosY] = positionEstimator(past_current_trial, modelParameters);
            end
            
            decodedPos = [decodedPosX; decodedPosY];
            decodedHandPos = [decodedHandPos decodedPos];
            
            meanSqError = meanSqError + norm(testData(tr,direc).handPos(1:2,t) - decodedPos)^2;
            
        end
        switch direc
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
        n_predictions = n_predictions+length(times);
        hold on
        Cp = strcat(C,'.');
        plot(decodedHandPos(1,:),decodedHandPos(2,:), Cp);
        plot(testData(tr,direc).handPos(1,times),testData(tr,direc).handPos(2,times),C)
        set(gca,'Color',[0.8 0.8 0.8]);
    end
end


legend('Decoded Position', 'Actual Position')

RMSE = sqrt(meanSqError/n_predictions)