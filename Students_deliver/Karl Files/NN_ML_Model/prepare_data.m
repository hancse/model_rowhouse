function [x_train, y_train, x_test, y_test,mu,sigma] = prepare_data(train_ratio)
  %% Function Description
  
if isfile('trainingTestData.mat')
     % File exists.
     load('trainingTestData.mat')
else
     % File does not exist.

  
  data_table = xlsread('FinalDatasetWithSumWithTotEnergy_corrected');
  
  %Normalization and Scaling
  [data_table_norm, mu, sigma]=zscore(data_table);

  % get the last 4 columns content and put them in a matrix which represents the input
  x = data_table_norm(:, 6:11);
  no_samples = size(x, 1);
  % get the y's
  y = data_table_norm(:, 3:5);
  
  
  
  
  % trainInd is a vector of indices which represent the indices of the training samples in the data matrix
  % testInd  is a vector of indices which represent the indices of the testing samples in the data matrix
  [trainInd, testInd] = divrand(no_samples, train_ratio);
  x_train = x(trainInd, :)';
  y_train = y(trainInd, :)';
  x_test  = x(testInd, :)';
  y_test  = y(testInd, :)';
end
  
end
