figure;
clf;
subplot(2,4,1)
imagesc(original_img);
axis image; colormap gray;
title('Original image')
subplot(2,4,5)
imhist(original_img)
subplot(2,4,2)
imagesc(MIG);
axis image; colormap gray;
title('MIG')
subplot(2,4,6)
imhist(uint8(MIG))
subplot(2,4,3)
imagesc(output);
axis image; colormap gray;
title('MRC')
subplot(2,4,7)
imhist(uint8(output))
subplot(2,4,4)
imagesc(uint8(AI));
axis image; colormap gray;
title('ALI')
subplot(2,4,8)
imhist(uint8(AI))

figure; clf
subplot(1,4,1)
imagesc(original_img(1:101,128-50:128+50));
axis image; colormap gray;
title('Original image')
subplot(1,4,2)
imagesc(MIG(1:101,128-50:128+50));
axis image; colormap gray;
title('MIG')
subplot(1,4,3)
imagesc(output(1:101,128-50:128+50));
axis image; colormap gray;
title('MRC')
subplot(1,4,4)
imagesc(uint8(AI(1:101,128-50:128+50)));
axis image; colormap gray;
title('ALI')