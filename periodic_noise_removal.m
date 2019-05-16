% Amy Cheng
% HW2 for BME 544

% I did a band-reject filter for the outer ring of the 2D Fourier transform
% This eliminated the periodic noise in the signal!

clear all
close all
data = Tiff('HW_Lecture8_Image.tiff','r');
image = read(data);

%% Take fourier transform
freq = fft2(image);
saveit = freq;
freq = fftshift(freq);
freq = abs(freq);
freq = log(freq+1);
freq = mat2gray(freq);

%% Make a low pass filter
size_x = size(freq,1);
size_y = size(freq,2);
[columnsInImage, rowsInImage] = meshgrid(1:size_x, 1:size_y);
center_x = size_x/2;
center_y = size_y/2;
radius = 290;

circlePixels = (rowsInImage - center_y).^2 ...
    + (columnsInImage - center_x).^2 <= radius.^2;

circlePixels = circlePixels - ((rowsInImage - center_y).^2 + (columnsInImage - center_x).^2 <= 160.^2);
circlePixels = abs(circlePixels -1);

%% Filter the image

filtered_fourier = saveit .* circlePixels;
filtered_image = ifft2(filtered_fourier);
filtered_image = mat2gray(abs(filtered_image));

%% Plot

figure(1)
subplot(2,2,1)
imshow(image)
title('Original image')
subplot(2,2,2)
imshow(freq)
title('Fourier transform')
subplot(2,2,3)
imshow(circlePixels)
title('Filter')
subplot(2,2,4)
imshow(filtered_image)
%imshow(freq .* circlePixels)
title('Filtered image')
