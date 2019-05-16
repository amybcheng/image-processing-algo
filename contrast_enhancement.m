clear all
close all
p=rgb2gray(imread('SD1077OS_121907.jpg'));%h=imshow(p);imcontrast(h)
Pnew=p/4;
Pnew2=Pnew;
subplot(1,2,1);
h=imagesc(Pnew2); colormap(gray);%imcontrast(h)
axis image
image_size=size(Pnew2)
number_of_pixels=image_size(1,1)*image_size(1,2)

Pnew2_modified=Pnew2;
Pnew2_modified(1,1)=255;
 subplot(1,2,2);
h_mod=imagesc(Pnew2_modified); colormap(gray);%imcontrast(h_mod)
 axis image