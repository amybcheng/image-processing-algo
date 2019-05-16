function [lambda] = cost_function(i,H,L)
% Amy Cheng; April 2019
% Function to calculate the loss associated with each classification
% Pixel can be classified into any other category, so 2^(2(H-L)) values
% here
% lambdaij gives loss in classifying pixel values with category i into j
% Maximize PSNR of new image, inversely proportional to sq error.
% Sq error of ji = (i-j)^2, so lambdaij = (i-j)^2. if i=j, loss is 0.

% i: how we're going to classify it
% lambdas: returns an array 1:2^(H-L), squared error

shift = H-L;

j = 1:2^shift;

lambda = (i-j).^2;

%lambda = j./j;

lambda = lambda./sum(lambda(:));

end

