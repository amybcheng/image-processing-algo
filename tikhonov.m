%% Image 1: Man at telescope
% PSF: 19x19 uniform
% BSNR: 40 dB
BSNR = 40;

filename = 'cameraman_19x19_BSNR40dB_RMSE296733.png';
blurred = imread(filename);

filename = 'cameraman_Original.tif';
original = imread(filename);

% build PSF
N = 19;
ind = -floor(N/2) : floor(N/2);
[X Y] = meshgrid(ind, ind);
h = X.^0 + Y.^0;
PSF = h/sum(h(:));

% PSF transpose
PSF_t = flipud(fliplr(PSF));

%%

gamma = fspecial('laplacian',0.5);
gamma_t = flipud(fliplr(gamma));

min_res = 1e10;

lambdas = logspace(-20,20,50);
x_axis = zeros(length(lambdas),1);
y_axis = zeros(length(lambdas),1);

for j=1:1
    
    lambda = sqrt(lambdas(j));
    lambda = 9;

    fk = edgetaper(blurred,fspecial('gaussian',20,5));

    iter = 1000;

    for i=1:iter
        % build H
        Hf = uint8(conv2(fk,PSF,'same'));

        first_term = -2*(conv2((blurred-Hf),PSF_t,'same'));

        second_term = conv2(fk,gamma,'same');
        
        if i==215
            hey=3;
        end
        
        second_term = 2.*lambda.*conv2(second_term,gamma_t,'same');
        
        if (isnan(sum(second_term)))
           hey=2; 
        end

        mu = .1;

        fk = double(fk) + -mu.*(first_term + second_term);
        
        residual = double(original) - fk;
        residual = norm(residual(:));
        
%         if (residual < min_res)
%             min_res = residual;
%             best_one = fk;
%             best_lambda = lambda;
%         end
        
        if sum(isinf(fk))>0
            hey=1;
        end

    end
    
    temp = double(blurred)-conv2(fk,PSF,'same');
    %temp = double(original)-fk;
    x_axis(j) = norm(temp(:));
    y_axis(j) = norm(fk(:));
    

end

%%

figure(1)
subplot(1,2,1)
imshow(blurred);
subplot(1,2,2)
imagesc(best_one);
axis image
colormap gray

figure(2)
%plot(log(x_axis),log(y_axis),'k.')
loglog(x_axis,y_axis,'ko')

figure(3)
subplot(1,2,1)
imagesc(first_term/2);
axis image
colormap gray
subplot(1,2,2)
imagesc(second_term/2);
axis image
colormap gray
