function [out] = mig(I,H,L,flag)
% Amy Cheng; April 2019
% Function to make a L-bit-depth multiplicative intensity gain image into H-bit-depth
% I: the image
% H: the desired bit depth
% L: the current bit depth
% flag: if 1, then will generate a plot

M = (2^(H)-1)/(2^(L)-1);
out = I .* M;

if flag==1
    figure;
    clf;
    subplot(2,2,1)
    imshow(I)
    title('Low BD image')
    subplot(2,2,2)
    imshow(out)
    title('High BD image, MIG')
    subplot(2,2,3)
    imhist(I)
    title('Low BD graylevel hist')
    subplot(2,2,4)
    imhist(out)
    title('High BD graylevel hist, MIG')

end


end

