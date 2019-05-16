function [filtered_image] = bilateral_filter(input_image, sigmag, sigmar)
% Amy Cheng
% BME 544 Spring 2019
% HW 2
% "An mfile that takes an arbitrary sized image, radiometric, and geometric
% variances as input, implements the bilateral filter, outputs the filtered
% image."
% I looked at code in bfilter2 by Douglas Lanman online.
% Sigma r is similarity/radiometric
% Sigma g is geometric/closeness

input_image = double(input_image); % convert type

width = size(input_image,2);
height = size(input_image,1);
w=3*max(sigmag,sigmar); % how big is our window? big w, long computation time. set to 3 standard deviations of the wider gaussian.

%% Precalculate Gaussian distance weights
[X,Y]=meshgrid([-w:1:w],[-w:1:w]); % meshgrid centered at 0, in a square that is 2w x 2w
geometric_gaussian = exp(-(X.^2+Y.^2)/(2*sigmag^2));

%% Iterate over every pixel in input_image
filtered_image = input_image; % allocate space
for i=1:height % rows
    for j=1:width % cols
        
        i_min = max(i-w,1); % if at the edge, take 1
        i_max = min(i+w,height); % if at the edge, take last row
        j_min = max(j-w,1); % if at the edge, take 1
        j_max = min(j+w,width); % if at the edge, take last col
        
        windowed = input_image(i_min:i_max,j_min:j_max); % select the windowed portion of input image
        
        radiometric_gaussian = exp(-(windowed-input_image(i,j)).^2/(2*sigmar^2)); % take difference of intensity as a gaussian
         
        product_gaussian = radiometric_gaussian.*geometric_gaussian((i_min:i_max) - i + w + 1, (j_min:j_max) - j + w + 1); % multiply both gaussians

        filtered_image(i,j) = sum(product_gaussian(:).*windowed(:))/sum(product_gaussian(:)); % apply the filter to the entire window, then average to find the value at pixel i,j
    end
end
end

