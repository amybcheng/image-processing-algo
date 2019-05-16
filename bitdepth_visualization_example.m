% Looking at bit depth display on low-res monitors

H=8;
L=1;
shift = H-L;

% Zero padding
filename = 'lena_Original.png';
original_img = imread(filename);

L_img = bitshift(original_img, -shift);
zero_padded = bitshift(L_img,shift);

% MIG
M = (2^(H)-1)/(2^(L)-1);
MIG = L_img .* M;

figure(1)
subplot(2,2,1)
imshow(original_img);
colormap gray
axis image
title('Original 8-bit Image')
subplot(2,2,2)
imshow(zero_padded);
colormap gray
axis image
title('ZP')
subplot(2,2,3)
imshow(MIG);
colormap gray
axis image
title('MIG')
subplot(2,2,4)
imshow(zero_padded-MIG);
colormap gray
axis image
title('MIG')