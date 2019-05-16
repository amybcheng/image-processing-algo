clear
close all

%%
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
                
% do super resolution

filename = '1.tif';
A = imread(filename);
A = im2double(A);

added = zeros((size(A,1)-1)*4,(size(A,2)-1)*4);
confidence = zeros((size(A,1)-1)*4,(size(A,2)-1)*4);

cum = zeros(3,3);

for i=1:16
    filename = strcat(int2str(i),'.tif');
    in = imread(filename);
    in = im2double(in);
    shift = shifts(i).matrix;
    %cum = cum + shift;
    cum = shift;
    neg = shift;
    neg(3,1) = cum(3,1)*-1;
    neg(3,2) = cum(3,2)*-1;
    neg(1,1) = 1;
    neg(2,2) = 1;
    neg(3,3) = 1;
    out = upsampleshiftback(in,neg);
    
    indices = find(out ~= 0); % look for holes?
    confidence(indices) = confidence(indices) + 1;
    
    added = added + out;
    
    figure(i)
    imagesc(added)
    colormap gray
    axis image
    
end

confidence = confidence./sum(confidence(:));
save('confidence.mat','confidence')

imwrite(uint8(added),'z.tif')