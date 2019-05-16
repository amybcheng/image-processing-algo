function [output] = adaptive_mean(input)
input=double(input);
width = size(input,1);
height = size(input,2);
mirrored = zeros(width*3,height*3);
output = zeros(width,height);

mirrored = [flipdim(flipdim(input,1),2) flipdim(input,1) flipdim(flipdim(input,1),2) ; 
            flipdim(input,2) input flipdim(input,2) ;
            flipdim(flipdim(input,1),2) flipdim(input,1) flipdim(flipdim(input,1),2)];

var_n = var(var(input));

w = 10; % window size

% if global > local, we're not on an edge: take the mean
% if 
        
for x=1:width
    for y=1:height
        g = input(x,y);
        m_x = width + x;
        m_y = height + y;
        neighborhood =  mirrored(m_x-w:m_x+w,m_y-w:m_y+w);
        var_l = var(var(neighborhood));
        mean_l = mean(mean(neighborhood));
        if (var_n > var_l)
            var_n = 2*var_l;
        end
        output(x,y) = g - (var_n./var_l).*(g-mean_l);
    end
end

end

