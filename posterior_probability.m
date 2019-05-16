function [probabilities] = posterior_probability(Pij, Iij,H,L,counts,bins)
% Amy Cheng; April 2019
% Function to calculate the posterior probability of each possible output
% Pij = P(i,j)
% Iij = I(i,j) from the low bit depth image
% H, L = self explanatory
% diff = vector of size 2^H-L
% counts, bins output of imhist (must be normalized)

shift = H-L;

diff = zeros(1,2^(shift));
probabilities = zeros(1,2.^(shift));

possible_vals = 0:(2^shift - 1);
possible_vals =  bsxfun(@plus, possible_vals, double(Iij.*2.^shift));

p = double(Pij).*ones(1,2.^(shift));

diff = p - possible_vals;

for i=1:2^(shift)
    hey = counts(find(bins==diff(i)));
    if numel(hey)>1
        probabilities(i) = hey(1);
    end
    if numel(hey)==1
        probabilities(i) = hey;
    end
    if numel(hey)<1
        probabilities(i) = 0;
    end
end

probabilities = probabilities ./ sum(probabilities); % normalize probabilities

end

