function g = sigmoidGradient(z)
g = sigmoid(z) .* (1 - sigmoid(z));
% for n=1:size(z,1)
%     if z >= 0
%         g(n,:)= 1;
%     else
%         g(n,:)=zeros(1,size(z,2));
%     end
% end

end