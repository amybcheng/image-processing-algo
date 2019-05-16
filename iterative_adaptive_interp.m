function [output] = iterative_adaptive_interp(input,w,iter)
if numel(w) == 1
    w = w.*ones(iter,1);
end

for t=1:iter
    temp = adaptive_interp(input,w(t));
    input = temp;
end

output = input;

end