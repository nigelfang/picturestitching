%% CSI 4116: Homework 5
%{
im1 = imread('keble1.png');
im2 = imread('keble2.png');

% keble1
PA = [165, 78; ...
      154, 186; ...
      327, 106; ...
      354, 170; ...
      340, 14; ...
      271, 43];
% keble2
PB = [68, 88; ...
      55, 198; ...
      229, 123; ...
      252, 186; ...
      243, 34; ...
      177, 57];
%}

im1 = imread('uttower1.jpeg');
im2 = imread('uttower2.jpeg');

% uttower1
PA = [481, 310; 328, 510; 106, 507; 108, 619; 56, 176; 129, 483; 526, 537; 375, 293];
% % uttower2
PB = [928, 331; 782, 540; 569, 545; 578, 652; 505, 232; 585, 519; 998, 567; 816, 322];

H = estimate_homography(PA, PB);

nr = size(im2, 1);
nc = size(im2, 2);
canvas = uint8(zeros(3*nr, 3*nc, 3));
canvas(nr:2*nr-1, nc:2*nc-1, :) = im2;

%% implement e2)
[rows,cols,~] = size(im1);
for y = 1:rows
    for x = 1:cols
        p1 = [x,y];
        p2 = apply_homography(p1, H);
        p2(1,1) = p2(1,1) + nc-1; % x coord
        p2(1,2) = p2(1,2) + nr-1; % y coord
        xUp = ceil(p2(1,1));
        xDown = floor(p2(1,1));
        yUp = ceil(p2(1,2));
        yDown = floor(p2(1,2));
        canvas(yUp, xUp, :) = im1(y,x, :);
        canvas(yUp, xDown, :) = im1(y,x, :);    
        canvas(yDown, xUp, :) = im1(y,x, :);
        canvas(yDown, xDown, :) = im1(y,x, :);
    end
end

imwrite(canvas, 'uttower_mosaic.png')