%% Part 3: Image Stitching
close all; clear; clc;

%% obtain the correspondence points
[pts_img1, pts_img2, img1, img2] = q3_gui;

%% define A matrix to obtain the H matrix
A = zeros(8, 9);
for k = 1:4
    x1 = pts_img1(1, k);
    y1 = pts_img1(2, k);
    x2 = pts_img2(1, k);
    y2 = pts_img2(2, k);
    A(2 * k - 1, :) = [x2 y2 1 0 0 0 -x2*x1 -x1*y2 -x1];
    A(2 * k, :) = [0 0 0 x2 y2 1 -y1*x2 -y2*y1 -y1];
end

%% find the homography matrix using Singular Value Decomposition
[U, S, V] = svd(A);
Homography = reshape(V(:, end), [3, 3]);
Homography = transpose(Homography);  

%% transform image 2 to image 1's space
[img2_transformed, min_x, min_y] = homography_transform(img2, Homography);
offset = [-min_x; -min_y];

%% stitch the two images for panorama
output = stitch_two_images(img1, img2_transformed, offset);
imshow(output);
