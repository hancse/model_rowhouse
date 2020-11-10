function [error_metrics,e] = eval_Data(y, y_pred )

%use continous value error metrics
  for i=1:size(y,1)
      T=y(i,:);
      P=y_pred(i,:);
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