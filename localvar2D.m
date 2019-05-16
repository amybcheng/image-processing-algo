function [output] = localvar2D(input,w)
input=double(input);
width = size(input,1);
height = size(input,2);
mirrored = zeros(width*3,height*3);
output = zeros(width,height);

mirrored = [flipdim(flipdim(input,1),2) flipdim(input,1) flipdim(flipdim(input,1),2) ; 
            flipdim(input,2) input flipdim(input,2) ;
            flipdim(flipdim(input,1),2) flipdim(input,1) flipdim(flipdim(input,1),2)];

% if global > local, we're not on an edge: take the mean
% if 

wind = round(w/2);
        
for x=1:width
    for y=1:height
        g = input(x,y);
        m_x = width + x;
        m_y = height + y;
        tmp =  mirrored(m_x-wind:m_x+wind,m_y-wind:m_y+wind);
        mu = mean(tmp(:));
        tmp2 = mean(tmp(:).^2);
        output(x,y)=tmp2 - mu.^2;
        
    end
end
output=uint8(output);
end

