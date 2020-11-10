function [trainInd,testInd] = divrand(n_samples,trainRatio)
  %% Function Description
  % This function splits a set of n_samples indices into training and test set indices

  % Input Parameters:
  % n_samples: total number of samples in out data
  % trainRatio: this is the ratio of the total samples we want to assign to the training data

  % Output Parameters:
  % trainInd: a vector of indices which represent the indices of the training samples in the data matrix
  % testInd:  a vector of indices which represent the indices of the testing samples in the data matrix

  % a random permutation of indices from 1 to n_samples
  all_Indices = randperm(n_samples);

  % the index of the last training sample
  lastTrainInd = round(trainRatio*n_samples);

  % the index of the first testing sample
  firstTestInd = lastTrainInd + 1;

  % a vector of training data indices
  trainInd = all_Indices(1:lastTrainInd);

  % a vector of testing data indices
  testInd  = all_Indices(firstTestInd:end);
end