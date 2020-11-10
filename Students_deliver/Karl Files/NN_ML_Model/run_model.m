function [error_metrics,e,y_pred] = run_model(x,y,sigma,mu,model)

%run model here
y_pred=model(x)

[error_metrics,e] = eval_Data(y, y_pred )


    fprintf('Error metrics output 1 (Heatpump) Trainindata:\n');
    error_metrics_output1(:)=error_metrics(:,1);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output1(1));
    fprintf('mse (mean squared error)%f\n',error_metrics_output1(2));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output1(3));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output1(4));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output1(5));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output1(6));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output1(7));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output1(8));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output1(9));
    
    
    fprintf('Error metrics output 2(Gas) Trainindata:\n');
    error_metrics_output2(:)=error_metrics(:,2);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output2(1));
    fprintf('mse (mean squared error)%f\n',error_metrics_output2(2));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output2(3));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output2(4));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output2(5));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output2(6));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output2(7));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output2(8));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output2(9));
    
    fprintf('Error metrics output 3(combined) Trainindata:\n');
    error_metrics_output3(:)=error_metrics(:,3);
    fprintf('mae (mean absolute error)%f\n',error_metrics_output3(1));
    fprintf('mse (mean squared error)%f\n',error_metrics_output3(2));
    fprintf('rmse (root mean squared error)%f\n',error_metrics_output3(3));
    fprintf('mare (mean absolute relative error)%f\n',error_metrics_output3(4));
    fprintf('msre (mean squared relative error)%f\n',error_metrics_output3(5));
    fprintf('rmsre (root mean squared relative error)%f\n',error_metrics_output3(6));
    fprintf('mape (mean absolute percentage error)%f\n',error_metrics_output3(7));
    fprintf('mspe (mean squared percentage error)%f\n',error_metrics_output3(8));
    fprintf('rmspe (root mean squared percentage error)%f\n',error_metrics_output3(9));
    
    %calculate absoulte errors in same metrics as original data
    fprintf('absolute Errors:\n');
    Errors=e.*sigma(:,3:5)+mu(:,3:5)
    
    fprintf('predicted Values:\n');
    predictedValues=y_pred'.*sigma(:,3:5)+mu(:,3:5)
    
    fprintf('actual Values:\n');
    actualValues=y'.*sigma(:,3:5)+mu(:,3:5)
    
    
    
    figure()
    plot(predictedValues)
    hold on
    plot(actualValues)
    legend('HeatPump Predicted','Gas Predicted','Combined Predicted','Heatpump Actual','Gas Actual','Combined Actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(predictedValues(:,1:2))
    hold on
    plot(actualValues(:,1:2))
    legend('HeatPump\_predicted','Gas\_predicted','Heatpump\_actual','Gas\_actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(predictedValues(:,3))
    hold on
    plot(actualValues(:,3))
    legend('Combined Predicted','Combined Actual')
    title('Predicted vs actual Heat production')
    xlabel('Sample');
    ylabel('KW');
    hold off
    
    figure()
    plot(Errors)
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Heatpump', 'Gas', 'Combined');
    
    figure()
    plot(Errors(:,1:2));
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Heatpump', 'Gas');
    
    figure()
    plot(Errors(:,3));
    title('Residuals')
    xlabel('Sample');
    ylabel('KW');
    legend('Combined');
    