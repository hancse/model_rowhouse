function [error_metrics,e,y_pred] = eval_network(x_test, y_test, W1, W2, b1, b2)
  %% Function Description
  % This function runs a forward pass of the test data to get the network's output
  % then compares it to the ground truth to return the testing accuracy

  % Input parameters:
  % x_test is a matrix where every column represents a single testing sample
  % y_test is a matrix where every column is a one-hot encoded output vector of a training example
  % W1 is a matrix of dimensions (n_hidden, n_input) where W1(i, j) is the weight connecting the i_th hidden layer neuron to the j_th input neuron
  % b1 is a vector with dimensions(n_hidden, 1) where b(i) is the bias associated with the i_th hidden layer neuron
  % W2 is a matrix of dimensions (n_output, n_hidden) where W2(i, j) is the weight connecting the i_th output layer neuron to the j_th hidden layer neuron
  % b2 is a vector with dimensions(n_output, 1) where bi is the bias associated with the i_th output neuron

  % Output parameters:
  % test_acc is the testing accuracy (no. of samples the network got right out of all the testing samples)

  % number of test samples
  n_samples = size(x_test, 2);

  % hidden_net(i, j) is the net input to the i_th hidden neuron for the j_th training example
  hidden_net = W1*x_test + repmat(b1, 1, n_samples);

  % hidden_activation(i, j) is the output of the i_th hidden neuron for the j_th training example
  hidden_activation = sigmoid(hidden_net);

  % out_net(i, j) is the input to the i_th output neuron for the j_th training example
  out_net = W2*hidden_activation +  repmat(b2, 1, n_samples);

  % out_activation(i, j) is the output of the i_th output  neuron for the j_th training example
  out_activation = sigmoid(out_net);

  % Network output = output_activation
  network_output=out_activation;
  y_pred=out_activation;

  %use continous value error metrics
  for i=1:size(y_test,1)
      T=y_test(i,:);
      P=network_output(i,:);
%   mae (mean absolute error)
mae(i) = errperf(T,P,'mae');
%   mse (mean squared error)
mse(i)= errperf(T,P,'mse');
%   rmse (root mean squared error)
rmse(i)=errperf(T,P,'rmse');
%
%   mare (mean absolute relative error)
mare(i)=errperf(T,P,'mare');
%   msre (mean squared relative error)
msre(i)=errperf(T,P,'msre');
%   rmsre (root mean squared relative error)
rmsre(i)=errperf(T,P,'rmsre');
%
%   mape (mean absolute percentage error)
mape(i) = errperf(T,P,'mape');
%   mspe (mean squared percentage error)
mspe(i)=errperf(T,P,'mspe');
%   rmspe (root mean squared percentage error)
rmspe(i)=errperf(T,P,'rmspe');

%   e (errors)
e(:,i)=errperf(T,P,'e');
%   ae (absolute errors)
ae(:,i)=errperf(T,P,'ae');
%   se (squared errors)
se(:,i)=errperf(T,P,'se');
%
%   re (relative errors)
re(:,i)=errperf(T,P,'re');
%   are (absolute relative errors)
are(:,i)=errperf(T,P,'are');
%   sre (squared relative errors)
sre(:,i)=errperf(T,P,'sre');
%
%   pe (percentage errors)
pe(:,i)=errperf(T,P,'pe');
%   ape (absolute percentage errors)
ape(:,i)=errperf(T,P,'ape');
%   spe (squared percentage errors)
spe(:,i)=errperf(T,P,'spe');


  end
error_metrics=  [mae;mse;rmse;mare;msre;rmsre;mape;mspe;rmspe];
%errors = [e,ae,se,re,are,sre,pe,ape,spe]

end
