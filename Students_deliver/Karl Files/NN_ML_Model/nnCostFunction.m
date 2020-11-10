function [J grad] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, num_labels, X, y, lambda)
%% Function description
% This function implements the neural network cost function for a two layer
% neural network which performs classification
% Implementation can be either vectorized or sequential by commenting out
% the desired part within %\\


% Reshaping of nn_params back into the parameters Theta1 and Theta2
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));

% size of dataset
m = size(X, 1);
         
% Output variables (dummmy)
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));


%% Cost function

%FORWARD PROPAGATION
a1 = [ones(m, 1) X]; %(number of samples [105], number of inputs +1 [5])

z2 = a1 * Theta1'; %(number of samples [105], number of hidden layer neurons [2])
a2 = sigmoid(z2);  %(number of samples [105], number of hidden layer neurons [2])
a2 = [ones(size(a2,1), 1) a2];  %(number of samples [105], number of hidden layer neurons +1 [3])

z3 = a2 * Theta2';  %(number of samples [105], number of outputs [3])
a3 = sigmoid(z3);  %(number of samples [105], number of outputs [3])
hThetaX = a3;       %Hypothesis

%COST
%unregularized cost
J = 1/m * sum(sum(-1 * y .* log(hThetaX)-(1-y) .* log(1-hThetaX)));
%Regularization penalty for big weights to avoid overfitting
regularator = (sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2))) * (lambda/(2*m));
J = J + regularator;

%% Gradient


% Vectorized Implementation

%FORWARD PROPAGATION (already done in part 1, so stays commented out here)
% a1 = [ones(m, 1) X]; %(number of samples [105], number of inputs +1 [5})
% 
% z2 = a1 * Theta1'; %(number of samples [105], number of hidden layer neurons [2])
% a2 = sigmoid(z2);  %(number of samples [105], number of hidden layer neurons [2])
% a2 = [ones(size(a2,1), 1) a2];  %(number of samples [105], number of hidden layer neurons +1 [3])
% 
% z3 = a2 * Theta2';  %(number of samples [105], number of outputs [3])
% a3 = sigmoid(z3);  %(number of samples [105], number of outputs [3])
% not needed, as already calculated in part 1

%BACK PROPAGATION   %\\
delta_3 = a3-y ; %(number of samples [105], number of outputs [3])

delta_2 = (Theta2' * delta_3')' .* [ones(size(sigmoidGradient(z2),1),1) sigmoidGradient(z2)];  %(number of samples [105], number of hidden layer neurons +1 [3])
delta_2 = delta_2(:,2:end);  %(number of samples [105], number of hidden layer neurons [2])

Theta1_grad = delta_2' * a1; %size(Theta1)
Theta2_grad = delta_3' * a2; %size(Theta2)  %\\


% Sample-wise implementation %\\

% for t = 1:m
%   
%   %FORWARD PROPAGATION
% 	% input layer
% 	a1 = [1; X(t,:)'];
% 
% 	% hidden layers
% 	z2 = Theta1 * a1;
% 	a2 = [1; sigmoid(z2)];
% 
% 	z3 = Theta2 * a2;
% 	a3 = sigmoid(z3);
% 
%   %BACK PROPAGATION
% 	yy = y(t);
% 	% delta values
% 	delta_3 = a3 - yy;
% 
% 	delta_2 = (Theta2' * delta_3) .* [1; sigmoidGradient(z2)];
% 	delta_2 = delta_2(2:end); % Taking of the bias row
% 
% 	% delta_1 is not calculated because the error is not associated with the input    
% 
% 	% Big delta update
% 	Theta1_grad = Theta1_grad + delta_2 * a1';
% 	Theta2_grad = Theta2_grad + delta_3 * a2';
% end       %\\

%Regularization of big delta and division by number of samples (same for both implementations)
Theta1_grad = (1/m) * Theta1_grad + (lambda/m) * [zeros(size(Theta1, 1), 1) Theta1(:,2:end)];
Theta2_grad = (1/m) * Theta2_grad + (lambda/m) * [zeros(size(Theta2, 1), 1) Theta2(:,2:end)];

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end