%clear all; close all; clc
%% load images
H=8;
L=4;
shift = H-L;

%filename = 'lena_Original.png';
filename = 'cameraman_Original.tif';
original_img = imread(filename);
%original_img = original_img(1:5:end,1:5:end); % downsample
original_img = uint8(original_img);

%% expand image
L_img = bitshift(original_img, -shift);
MIG = mig(L_img,H,L,0);

%% do adaptive interpolation
MIG = double(MIG);
AI = adaptive_interp(MIG,3);
%AI = iterative_adaptive_interp(MIG,3,10);

figure; clf
imagesc(AI);colormap gray;axis image

figure; clf;
subplot(2,3,1)
imshow(original_img)
title('High BD image')
subplot(2,3,4)
imhist(original_img)
title('High BD graylevel hist')
subplot(2,3,2)
imshow(uint8(MIG))
title('Low BD image')
subplot(2,3,5)
imhist(uint8(MIG))
title('Low BD graylevel hist')
subplot(2,3,3)
imshow(uint8(AI))
title('Adaptive interpolated image')
subplot(2,3,6)
imhist(uint8(AI))
title('Adaptive interpolated hist')

%% error image
figure; clf
imagesc(uint8(MIG)-uint8(AI)); colormap gray; axis image

% %% cross section
% 
% figure;
% clf;
% subplot(2,1,1)
% cross_section = uint8(MIG(400:500,:));
% cross_section(45,10:502)=255;
% cross_section(56,10:502)=255;
% cross_section(45:56,10)=255;
% cross_section(45:56,502)=255;
% imshow(cross_section)
% title('Low bit depth image')
% subplot(2,1,2)
% row_h = original_img(450,:);
% row_l = MIG(450,:);
% local_var = movvar(row_l,10);
% row_i = AI(450,:);
% plot(1:512,row_h,1:512,row_l,1:512,row_i, 'LineWidth',1);
% xlim([1 512])
% ylim([0 255])
% yyaxis left
% ylabel('Value')
% hold on
% yyaxis right
% plot(1:512,local_var,'LineWidth',2)
% ylabel('Var')
% legend('Original image','Low bit depth image','Interpolated image','Variance of low bit depth')
% title('Row taken from low bit depth image')
% grid on
% 

%% print stats
fprintf('\n The Peak-SNR value is %0.4f\n', psnr(uint8(MIG),original_img));
fprintf('\n The Peak-SNR value is %0.4f\n', psnr(uint8(AI),original_img));

fprintf('\n The MSE value is %0.4f\n', immse(uint8(MIG),original_img));
fprintf('\n The MSE value is %0.4f\n', immse(uint8(AI),original_img));

fprintf('\n The SSIM value is %0.4f\n', ssim(uint8(MIG),original_img));
fprintf('\n The SSIM value is %0.4f\n', ssim(uint8(AI),original_img));