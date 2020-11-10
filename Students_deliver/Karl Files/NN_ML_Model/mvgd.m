function [theta, J_history] = mvgd(X, y, theta, alpha, iterations,threshold)
% MVGD 	Multivariate gradient descent
%   [theta, J_history] = mvgd(X, y, theta, alpha, iterations) performs
%   Multivariate gradient descent over a given number of iterations.
%
%   [theta, J_history] = mvgd(X, y, theta, alpha, 0,threshold)  performs
%   Multivariate gradient descent until the change of the cost function
%   falls below a given threshold. If no threshold is given, a standard
%   value of 0.1 is used.
%
%   See also MVREGRESS.



m=length(X);

if iterations >0    
    for i=1:iterations
        err=sum(theta'.*X,2)-y;     %compute error term only once for faster iteration
        J_history(i)=1/2/m*sum(err.^2);  %cost function
        theta = theta-alpha/m*sum(err.*X)'; %new theta
    end
else
    if ~exist('threshold','var')
        threshold = 0.1; 
    end
    i=0;
    J_change=inf;
    while J_change>threshold
        i=i+1; 
        err=sum(theta'.*X,2)-y;     %compute error term only once for faster iteration
        J_history(i)=1/2/m*sum(err.^2);  %cost function
        theta = theta-alpha/m*sum(err.*X)'; %new theta  
        if i>1
            J_change=J_history(i-1)-J_history(i); %compare last with current cost
        end
        
    end
end
