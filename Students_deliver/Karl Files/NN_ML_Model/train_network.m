function [W1, W2, b1, b2] = train_network(x_train, y_train, a, n_epochs, W1_0, b1_0, W2_0, b2_0)
%% Function Description
% This function trains the network using the backpropagation algorithm

% Input parameters:
% x_train is a matrix where every column represents a single training sample
% y_train is a matrix where every column is a one-hot encoded output vector of a training sample
% a is the learning rate
% n_epochs is the number of complete passes over the whole training dataset
% W1_0, b1_0, W2_0, b2_0: initial weight matrices and bias vectors values

% Output Parameters:
% W1, W2, b1, b2: trained weight matrices and bias vectors values

%% ASSIGNMENT 2: implement the neural network training
% Forward initial weights (dummy) This is just for testing purposes, and
% has no further intended function
% W1=W1_0;
% W2=W2_0;
% b1=b1_0;
% b2=b2_0;

%VECTORIZE
%create Theta vectors from weights and biases (bias neuron sits on top)
initial_Theta1=[b1_0 W1_0];
initial_Theta2=[b2_0 W2_0];
%unroll theta vecotrs to work with fminunc
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%PREPARE ADDITIONAL PARAMETERS
% parameters for cost function  
input_layer_size = size(W1_0,2);    %to recreate Theta1
hidden_layer_size = size(W1_0,1);   %to recreate Theta1 and Theta2
num_labels = size(y_train,1);       %to recreate Theta2
lambda =a;                          %just for better understanding as learning rate is usually called lambda
% set maximum amount of iterations in fminunc
options = optimset('MaxIter', n_epochs);

%OPTIMIZATION
% create function handle (anonymous function) for fminunc
costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, num_labels, x_train', y_train', lambda);
% run fminunc                               
[nn_params, cost,ExitFlag] = fminunc(costFunction, initial_nn_params, options);

%RESAHPE
% split up theta1 and theta2
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));
%split up b's and W's
b1=Theta1(:,1:size(b1_0,2));
W1=Theta1(:,size(b1_0,2)+1:end);
b2=Theta2(:,1:size(b2_0,2));
W2=Theta2(:,size(b2_0,2)+1:end);
end