% Import high resolution image

filename = 'cameraman_Original.tif';
A = imread(filename);

A = im2double(A);

files = 1:1:16;


% Create shifts
shifts(1).matrix = [ 1  0  0
                    0  1  0
                    0  0  1 ];
shifts(2).matrix = [ 1  0  0
                    0  1  0
                    .7  .9  1 ];
shifts(3).matrix = [ 1  0  0
                    0  1  0
                    0  -.2  1 ];
shifts(4).matrix = [ 1  0  0
                    0  1  0
                    0  1  1 ];
shifts(5).matrix = [ 1  0  0
                    0  1  0
                    .5  0  1 ];
shifts(6).matrix = [ 1  0  0
                    0  1  0
                    -1  .3  1 ];
shifts(7).matrix = [ 1  0  0
                    0  1  0
                    -.5  .5  1 ];
shifts(8).matrix = [ 1  0  0
    0  1  0
    0  -.5  1 ];
shifts(9).matrix = [ 1  0  0
    0  1  0
    -1  -1  1 ];
shifts(10).matrix = [ 1  0  0
    0  1  0
    -.5  .5  1 ];
shifts(11).matrix = [ 1  0  0
    0  1  0
    1  -1  1 ];
shifts(12).matrix = [ 1  0  0
    0  1  0
    .5  -.5  1 ];
shifts(13).matrix = [ 1  0  0
    0  1  0
    .5  -.5  1 ];
shifts(14).matrix = [ 1  0  0
    0  1  0
    .87  -.5  1 ];
shifts(15).matrix = [ 1  0  0
    0  1  0
    -.5  0  1 ];
shifts(16).matrix = [ 1  0  0
    0  1  0
    0  -.7  1 ];
                
% Create 16 shifted (subpixel) images

for i=1:length(files)
    
    filename = strcat(int2str(i),'.tif');
    
    xform = shifts(i).matrix;
    tform = maketform('affine',xform);
    B = imtransform(A,tform,'XData',[1 size(A,2)],'YData',[1 size(A,1)]);
    
    A=B;

    % Blur each image

    kernel = fspecial('ga',5,1.5);
    C = conv2(B,kernel);

    % Downsample each image by 4

    D = C(1:4:end,1:4:end);

    % Add noise to each image

    E = imnoise(D,'Gaussian',0,0.01)*255;
    
    % Write a file
    
    imwrite(uint8(E),filename)

    % Check

    figure(i)
    subplot(3,2,1)
    imagesc(A);
    axis image
    colormap gray
    subplot(3,2,2)
    imagesc(B);
    axis image
    colormap gray
    subplot(3,2,3)
    imagesc(C);
    axis image
    colormap gray
    subplot(3,2,4)
    imagesc(D);
    axis image
    colormap gray
    subplot(3,2,5)
    imagesc(E);
    axis image
    colormap gray
end