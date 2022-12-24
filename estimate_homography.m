function H = estimate_homography(PA, PB)
[rows,~] = size(PA);
% rows = N correspondences; col = 2
% A should be a 2N x 9 array
A = zeros(rows * 2, 9);
coordCounter = 1;
for i = 1:2:rows*2
    A(i,1) = -(PA(coordCounter,1));
    A(i,2) = -(PA(coordCounter,2));
    A(i,3) = -1;
    A(i,4) = 0;
    A(i,5) = 0;
    A(i,6) = 0;
    A(i,7) = PA(coordCounter,1) * PB(coordCounter,1);
    A(i,8) = PA(coordCounter,2) * PB(coordCounter,1);
    A(i,9) = PB(coordCounter,1);
    coordCounter = coordCounter + 1;
end
coordCounter = 1;
for i = 2:2:rows*2
    A(i,1) = 0;
    A(i,2) = 0;
    A(i,3) = 0;
    A(i,4) = -(PA(coordCounter,1));
    A(i,5) = -(PA(coordCounter,2));
    A(i,6) = -1;
    A(i,7) = PA(coordCounter,1) * PB(coordCounter,2);
    A(i,8) = PA(coordCounter,2) * PB(coordCounter,2);
    A(i,9) = PB(coordCounter,2);
    coordCounter = coordCounter + 1;
end
[~, ~, V] = svd(A); 
h = V(:, end); 
H = reshape(h, 3, 3)';
end