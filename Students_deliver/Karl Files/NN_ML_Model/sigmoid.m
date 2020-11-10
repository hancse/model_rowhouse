function out = sigmoid(inp)
% this function simply calculates the sigmoid function for every entry in
% the input matrix inp and returns the result in the matrix out

 out = 1 ./ (1 + exp(-inp));
% for n=1:size(inp,1)
%     if inp > 0
%         out(n,:) = inp;
%     else
%         out(n,:) = zeros(1,size(inp,2));
%     end
% end

end
