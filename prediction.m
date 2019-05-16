function [P,E] = prediction(I)
% Amy Cheng; April 2019
% Function to "predict" each pixel in image I by taking the average of its
% four-connected neighbors.
% P: predicted iamge
% E: error image, E = I-P

P = zeros(size(I));
E = zeros(size(I));

I=double(I);

kernel = ones(2, 2) / 4; % 3x3 mean kernel
P = conv2(I, kernel, 'same'); % Convolve keeping size of I
E = int16(I-P);

% for i=1:size(I,1)
%     for j=1:size(I,2)
%         %neighbors = [I(i,max(j-1,1)) I(i,min(j+1,size(I,2))) I(max(i-1,1),j) I(min(i+1,size(I,2)),j)];
%         P(i,j) = mean(neighbors,2);
%         E(i,j) = int16(I(i,j))-P(i,j);
%     end
% end

end

