function [model, error] = train_model(model,inputs,targets)
outputs = predict(model,inputs);
error = targets - outputs;
change = inputs'*(error.*(1-(tanh(outputs)).^2));
model.weights = model.weights + change;
end

