load monkeydata_training.mat

model = struct()
model.weights = rand(3,1);

inputs = [[0 1 0];[1 0 0];[1 1 0]];
targets = [0 1 1];
train_model(model, inputs, targets)