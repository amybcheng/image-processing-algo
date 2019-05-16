function [value] = risk(Pij, Iij,H,L,counts,bins)
% Amy Cheng; April 2019
% Function to calculate conditional risk, and choose the minimum
% Called once per pixel
% Returns an integer between 1 to 2^H-L indicating which category has the
% minimum associated risk
shift = H-L;
num_poss = 2^shift;

probabilities = posterior_probability(Pij,Iij,H,L,counts,bins);
R = zeros(1,num_poss);
for i=1:num_poss
    lambdas = cost_function(i,H,L); % each col of lambdas is the cost of classifying a pixel belonging to i to categories 1->numposs
    probability = probabilities(i);
    %if probability==0
    %    probability = 10;
    %end
    R(i) = sum(probability .* lambdas);
end

mins = find(max(R)==R); %idk why but it's DEFINITELY max
if numel(mins)>1
    value = mins(round(end/2));
else
    value = mins;
end


end
