%% TARGET: Predict Heating energy dependent on  weather data
clear all
close all


for attempt = 1:1
    train_ratio = 0.7; % use 70% of the data as training data (automatically means 30% of the data goes to testing)
    
    % load the data
    [x_train, y_train, x_test, y_test,mu, sigma] = prepare_data(train_ratio);
    
    
    
    %% Defining the Network Architecture
    % our network is made of 3 layers (input , hidden and output layer)
    % the input layer  is made of 4 neurons (we have a 4 dimensional input)
    % the hidden layer is made of 1 neuron  (an very bad choice as you'll see, do play with this number)
    % the output layer is made of 3 neurons (we will have a one-hot encoded output which means:
    
    %% Defining the number of neurons in each layer
    n_inp = size(x_train,1) ;  % number of input neurons
    n_hidden = 10; % number of hidden layer neurons %Edit: original value 1
    n_out = size(y_train,1);  % number of output neurons
    
    % The network weights and biases are stored in the following matrices:
    % W1, which is a matrix of dimensions (n_hidden, n_input) where W1(i, j) is the weight connecting the i_th hidden neuron to the j_th input neuron
    % b1, which is a vector with dimensions(n_hidden, 1) where b(i) is the bias associated with the i_th hidden neuron
    % W2, which is a matrix of dimensions (n_output, n_hidden) where W2(i, j) is the weight connecting the i_th output neuron to the j_th hidden neuron
    % b2, which is a vector with dimensions(n_output, 1) where b(i) is the bias associated with the i_th output neuron
    
    W1_0 = 2*rand(n_hidden, n_inp) - 1; % randomly initialize W1 with values between -1 and 1
    b1_0 = 2*rand(n_hidden, 1) - 1;     % randomly initialize b1 with values between -1 and 1
    W2_0 = 2*rand(n_out, n_hidden) - 1; % randomly initialize the W2 matrix with values between -1 and 1
    b2_0 = 2*rand(n_out, 1) - 1;        % randomly initialize b2 with values between -1 and 1
    
    %% Training the network
    a = 10; % the learning rate -- this one is wrong, make sure to adjust it %Edit: original value 1
    n_epochs = 500000; % number of times we will make a complete pass over our training data
    tic      ;         %Edit: Start Timer for time needed for training
    [W1, W2, b1, b2] = train_network(x_train, y_train, a, n_epochs, W1_0, b1_0, W2_0, b2_0);
    Time(attempt)=toc  ;       %Edit: Gives array of times needed for training
    fprintf('time for training: %fs\n',Time(attempt));
    %% Test the network
    [error_metrics_test,e_test,y_pred_test] = eval_network(x_test, y_test, W1, W2, b1, b2);
    fprintf('Error metrics output 1 (Heatpump) Testdata:\n');
    error_metrics_output1_test(:,attempt)=error_metrics_test(:,1);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output1_test(1,attempt));
    fprintf('mse (mean squared error)%f\n',error_metrics_output1_test(2,attempt));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output1_test(3,attempt));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output1_test(4,attempt));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output1_test(5,attempt));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output1_test(6,attempt));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output1_test(7,attempt));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output1_test(8,attempt));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output1_test(9,attempt));
    
    
    fprintf('Error metrics output 2(Gas) Testdata:\n');
    error_metrics_output2_test(:,attempt)=error_metrics_test(:,2);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output2_test(1,attempt));
    fprintf('mse (mean squared error)%f\n',error_metrics_output2_test(2,attempt));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output2_test(3,attempt));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output2_test(4,attempt));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output2_test(5,attempt));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output2_test(6,attempt));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output2_test(7,attempt));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output2_test(8,attempt));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output2_test(9,attempt));
    
    fprintf('Error metrics output 3(combined) Testdata:\n');
    error_metrics_output3_test(:,attempt)=error_metrics_test(:,3);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output3_test(1,attempt));
    fprintf('mse (mean squared error)%f\n',error_metrics_output3_test(2,attempt));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output3_test(3,attempt));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output3_test(4,attempt));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output3_test(5,attempt));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output3_test(6,attempt));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output3_test(7,attempt));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output3_test(8,attempt));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output3_test(9,attempt));
    
    %calculate absoulte errors in same metrics as original data
    fprintf('absolute Errors:\n');
    Errors_test=e_test.*sigma(:,3:5)+mu(:,3:5)
    
    fprintf('predicted Values:\n');
    predictedValues_test=y_pred_test'.*sigma(:,3:5)+mu(:,3:5)
    
    fprintf('actual Values:\n');
    actualValues_test=y_test'.*sigma(:,3:5)+mu(:,3:5)
    
    figure()
    subplot(2,2,1)
    surface(W1)
    subplot(2,2,2)
    surface(W2)
    subplot(2,2,3)
    plot(b1)
    subplot(2,2,4)
    plot(b2)
    
    figure()
    plot(predictedValues_test)
    hold on
    plot(actualValues_test)
    legend('HeatPump Predicted','Gas Predicted','Combined Predicted','Heatpump Actual','Gas Actual','Combined Actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(predictedValues_test(:,1:2))
    hold on
    plot(actualValues_test(:,1:2))
    legend('HeatPump\_predicted','Gas\_predicted','Heatpump\_actual','Gas\_actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(predictedValues_test(:,3))
    hold on
    plot(actualValues_test(:,3))
    legend('Combined Predicted','Combined Actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(Errors_test)
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Heatpump', 'Gas', 'Combined');
    
    figure()
    plot(Errors_test(:,1:2));
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Heatpump', 'Gas');
    
    figure()
    plot(Errors_test(:,3));
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Combined');
    
    %% Evaluate on the training data:
    
    [error_metrics_train,e_train,y_pred_train] = eval_network(x_train, y_train, W1, W2, b1, b2);
    fprintf('Error metrics output 1 (Heatpump) Trainindata:\n');
    error_metrics_output1_train(:,attempt)=error_metrics_train(:,1);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output1_train(1,attempt));
    fprintf('mse (mean squared error)%f\n',error_metrics_output1_train(2,attempt));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output1_train(3,attempt));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output1_train(4,attempt));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output1_train(5,attempt));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output1_train(6,attempt));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output1_train(7,attempt));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output1_train(8,attempt));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output1_train(9,attempt));
    
    
    fprintf('Error metrics output 2(Gas) Trainindata:\n');
    error_metrics_output2_train(:,attempt)=error_metrics_train(:,2);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output2_train(1,attempt));
    fprintf('mse (mean squared error)%f\n',error_metrics_output2_train(2,attempt));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output2_train(3,attempt));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output2_train(4,attempt));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output2_train(5,attempt));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output2_train(6,attempt));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output2_train(7,attempt));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output2_train(8,attempt));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output2_train(9,attempt));
    
    fprintf('Error metrics output 3(combined) Trainindata:\n');
    error_metrics_output3_train(:,attempt)=error_metrics_train(:,3);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output3_train(1,attempt));
    fprintf('mse (mean squared error)%f\n',error_metrics_output3_train(2,attempt));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output3_train(3,attempt));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output3_train(4,attempt));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output3_train(5,attempt));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output3_train(6,attempt));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output3_train(7,attempt));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output3_train(8,attempt));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output3_train(9,attempt));
    
    %calculate absoulte errors in same metrics as original data
    fprintf('absolute Errors:\n');
    Errors_train=e_train.*sigma(:,3:5)+mu(:,3:5)
    
    fprintf('predicted Values:\n');
    predictedValues_train=y_pred_train'.*sigma(:,3:5)+mu(:,3:5)
    
    fprintf('actual Values:\n');
    actualValues_train=y_train'.*sigma(:,3:5)+mu(:,3:5)
    
    figure()
    subplot(2,2,1)
    surface(W1)
    subplot(2,2,2)
    surface(W2)
    subplot(2,2,3)
    plot(b1)
    subplot(2,2,4)
    plot(b2)
    
    figure()
    plot(predictedValues_train)
    hold on
    plot(actualValues_train)
    legend('HeatPump Predicted','Gas Predicted','Combined Predicted','Heatpump Actual','Gas Actual','Combined Actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(predictedValues_train(:,1:2))
    hold on
    plot(actualValues_train(:,1:2))
    legend('HeatPump\_predicted','Gas\_predicted','Heatpump\_actual','Gas\_actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(predictedValues_train(:,3))
    hold on
    plot(actualValues_train(:,3))
    legend('Combined Predicted','Combined Actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(Errors_train)
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Heatpump', 'Gas', 'Combined');
    
    figure()
    plot(Errors_train(:,1:2));
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Heatpump', 'Gas');
    
    figure()
    plot(Errors_train(:,3));
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Combined');
    
end
fprintf('\n finished\n');
