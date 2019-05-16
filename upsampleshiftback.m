function [out] = upsampleshiftback(image,shift)

A = image;

% upsample

upsampled = imresize(A,4,'nearest');
upsampled(1:4:end,2:4:end) = 0;
upsampled(1:4:end,3:4:end) = 0;
upsampled(1:4:end,4:4:end) = 0;
upsampled(2:4:end,1:4:end) = 0;
upsampled(2:4:end,2:4:end) = 0;
upsampled(2:4:end,3:4:end) = 0;
upsampled(2:4:end,4:4:end) = 0;
upsampled(3:4:end,1:4:end) = 0;
upsampled(3:4:end,2:4:end) = 0;
upsampled(3:4:end,3:4:end) = 0;
upsampled(3:4:end,4:4:end) = 0;
upsampled(4:4:end,1:4:end) = 0;
upsampled(4:4:end,2:4:end) = 0;
upsampled(4:4:end,3:4:end) = 0;
upsampled(4:4:end,4:4:end) = 0;

upsampled = upsampled(1:end-4,1:end-4);

% shift back

% shift = [ 1  0  0
%           0  1  0
%           0  0  1 ];
tform = maketform('affine',shift);
out = imtransform(upsampled,tform,'XData',[1 size(upsampled,2)],'YData',[1 size(upsampled,1)]);



% figure(1)
% subplot 141
% imagesc(A);
% axis image
% colormap gray
% subplot 142
% imagesc(upsampled);
% axis image
% colormap gray
% subplot 143
% imagesc(shiftedback);
% axis image
% colormap gray
% subplot 144
% imagesc(added);
% axis image
% colormap gray
end

