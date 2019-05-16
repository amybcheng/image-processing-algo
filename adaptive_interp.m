function [output] = adaptive_interp(input,w)

varpic =localvar2D(input,w);
avgvar = mean(mean(varpic));
mask = varpic<(avgvar*.8);
temp = regionfill(input,mask);
error = (temp-input).^2;
% if error is higher, weigh input more?
output = temp;
end