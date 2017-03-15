RMSE = [];

% Jonathan Campbell, Alexander Camuto, Enrico Tosoratti, Amna Askari

% (try not to edit this file too much - based off the file
% testFunction_for_students_MTb(1).m which assesses the performance of the
% model)


%% Continuous Position Estimator Test Script
% This function first calls the function "positionEstimatorTraining" to get
% the relevant modelParameters, and then calls the function
% "positionEstimator" to decode the trajectory.
RMSE = zeros(10,15);
for del = [1 2 3 4 5 6 7 8 9 10]
for hsize = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]
close all
load monkeydata_training.mat

% Set random number generator
rng(2013);
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
modelParameters = positionEstimatorTraining(trainingData,hsize,del);

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
        n_predictions = n_predictions+length(times);
        hold on
        plot(decodedHandPos(1,:),decodedHandPos(2,:), 'r');
        plot(testData(tr,direc).handPos(1,times),testData(tr,direc).handPos(2,times),'b')
    end
end


legend('Decoded Position', 'Actual Position')

RMSE(del,hsize) = sqrt(meanSqError/n_predictions);
end
end