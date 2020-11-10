clear all; close all; clc;

train_ratio = 0.7; % use 70% of the data as training data (automatically means 30% of the data goes to testing)
alpha = 0.3;
iterations =1000;

% load the data
  [x_train, y_train, x_test, y_test,mu, sigma] = prepare_data(train_ratio);
  X=x_train';
  y=y_train(3,:)';
  m=size(x_train,2);
  n = size(x_train, 1)-1;
  
% Add Y-displacement term
X = [ones(m, 1) X];

% Initial theta can be anything (except zeros)
theta = ones(n+1, 1)';

%  multivariate gradient descent
[theta, J_history] = mvgd(X, y, theta, alpha, iterations);



figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost');

if sum(isnan(theta(:))) > 0 || sum(isinf(theta(:))) > 0
  error('Theta ran out of bounds')    
end

fprintf('Computed theta:\n')
disp(theta)

% test samples
for i = 1:size(y_test(3,:),2)
  sample = i;
  input = [1 x_test(:,i)'];
  actual = y_test(3,i)';

  prediction = (input - [0 mu(:, 6:11)]) ./ [1 sigma(:, 6:11)] * theta;
  error(i)=prediction-actual;
  fprintf('Sample: %i, predicted: %f, actual: %f\n, error: %f\n', sample, prediction, actual, error(i));  
end
total_error=mean(abs(error))


