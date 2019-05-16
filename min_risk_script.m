clear all; close all; clc

%%
H=8;
L=4;
shift = H-L;

%filename = 'lena_Original.png';
filename = 'cameraman_Original.tif';
original_img = imread(filename);
%original_img = original_img(1:5:end,1:5:end); % downsample
original_img = uint8(original_img);

%%

L_img = bitshift(original_img, -shift);

zero_padded = zeropadding(L_img,H,L,0);

MIG = mig(L_img,H,L,0);

% figure;
% clf;
% subplot(2,2,3)
% imshow(original_img)
% title('High BD image')
% subplot(2,2,4)
% imhist(original_img)
% title('High BD graylevel hist')
% subplot(2,2,1)
% imshow(L_img)
% title('Low BD image')
% subplot(2,2,2)
% imhist(L_img)
% title('Low BD graylevel hist')

% figure;
% clf;
% subplot(3,2,1)
% imshow(original_img)
% title('High BD image')
% subplot(3,2,3)
% imshow(zero_padded)
% title('High BD image, ZP')
% subplot(3,2,5)
% imshow(MIG)
% title('High BD image, MIG')
% subplot(3,2,2)
% imhist(original_img)
% title('High BD graylevel hist')
% subplot(3,2,4)
% imhist(zero_padded)
% title('High BD graylevel hist, ZP')
% subplot(3,2,6)
% imhist(MIG)
% title('High BD graylevel hist, MIG')

[P E] = prediction(MIG);
P = uint8(P); % same as MIG
E = int8(E); % -128 to 128

%P = original_img;

figure;
clf;
subplot(2,3,1)
imagesc(MIG); axis image; colormap gray;
title('MIG, high BD image')
subplot(2,3,2)
imagesc(P); axis image; colormap gray;
title('Prediction image, averaging filter')
subplot(2,3,3)
imagesc(E); axis image; colormap gray;
title('Error image, MIG - Prediction')
subplot(2,3,4)
imhist(MIG);
subplot(2,3,5)
imhist(P);
subplot(2,3,6)
imhist(E)
[counts, bins] = imhist(E);

E=double(E);

counts=counts./numel(E); % normalized, probability

output = zeros(size(P));

for i=1:size(P,1)
    for j=1:size(P,2)
    val = risk(P(i,j), L_img(i,j),H,L,counts,bins);
    output(i,j) = category(L_img(i,j),val,H,L);
    end
end


figure;
clf;
subplot(2,3,1)
imagesc(MIG);
axis image; colormap gray;
title('High BD image, MIG')
subplot(2,3,4)
imhist(uint8(MIG))
title('High BD graylevel hist, MIG')
subplot(2,3,2)
imagesc(P);
axis image; colormap gray;
title('High BD image, P(MIG)')
subplot(2,3,5)
imhist(uint8(P))
title('High BD graylevel hist, P(MIG)')
subplot(2,3,3)
imagesc(output);
axis image; colormap gray;
title('High BD image, min. risk')
subplot(2,3,6)
imhist(uint8(output))
title('High BD graylevel hist, min. risk')

figure;
clf;
subplot(2,3,1)
imagesc(original_img);
axis image; colormap gray;
title('High BD image, original')
subplot(2,3,4)
imhist(original_img)
title('High BD graylevel hist, original')
subplot(2,3,2)
imagesc(MIG);
axis image; colormap gray;
title('High BD image, MIG')
subplot(2,3,5)
imhist(uint8(MIG))
title('High BD graylevel hist, MIG')
subplot(2,3,3)
imagesc(output);
axis image; colormap gray;
title('High BD image, min. risk')
subplot(2,3,6)
imhist(uint8(output))
title('High BD graylevel hist, min. risk')

saveas(gcf,'result.png')

fprintf('\n The Peak-SNR value is %0.4f\n', psnr(MIG,original_img));
fprintf('\n The Peak-SNR value is %0.4f\n', psnr(P,original_img));
fprintf('\n The Peak-SNR value is %0.4f\n', psnr(uint8(output),original_img));

fprintf('\n The MSE value is %0.4f\n', immse(MIG,original_img));
fprintf('\n The MSE value is %0.4f\n', immse(P,original_img));
fprintf('\n The MSE value is %0.4f\n', immse(uint8(output),original_img));

fprintf('\n The SSIM value is %0.4f\n', ssim(MIG,original_img));
fprintf('\n The SSIM value is %0.4f\n', ssim(P,original_img));
fprintf('\n The SSIM value is %0.4f\n', ssim(uint8(output),original_img));

function [out] = category(LowBD,i,H,L)
    if numel(i)<1
        out = LowBD * 2^(H-L) + 2^(H-L)/2;
    else
        out = LowBD * 2^(H-L) + i;
    end
end