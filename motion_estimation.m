function [v] = untitled(test,test_shift)

[Gx Gy] = imgradientxy(test);

f1_x = Gx;
f1_y = Gy;
f1_xt = f1_x.';
f1_yt = f1_y.';

W = sum(f1_x.^2);
X = sum(f1_xt.*f1_y);
Y = sum(f1_yt.*f1_x);
Z = sum(f1_y.^2);

big_matrix = horzcat(sum(W) , sum(X));
big_matrix_bottom = horzcat(sum(Y), sum(Z));
big_matrix = vertcat(big_matrix,big_matrix_bottom);
big_matrix = inv(big_matrix);

next = horzcat(f1_x(:),f1_y(:));
next = next.';

last = test_shift-test;
last = last(:);

v = big_matrix * next * last;

end

