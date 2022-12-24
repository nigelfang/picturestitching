function [p2] = apply_homography(p1, H)
p1(3) = 1;
p1 = p1';
p = H * p1;
p2 = p(1:2) ./ p(3);
p2 = p2';
end