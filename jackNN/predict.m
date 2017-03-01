function output = predict(model,inputs)
output = tanh(inputs*model.weights);
end

