%% Part 2: Homography and Transformation
close all; clear; clc;

%% obtain the correspondence points
[pts_img1, pts_img2, img1, img2] = q2_gui;

%% define A matrix to obtain the H matrix
A = zeros(8, 9);
for k = 1 : 4
    x1 = pts_img1(k, 1);
    y1 = pts_img1(k, 2);
    x2 = pts_img2(k, 1);
    y2 = pts_img2(k, 2);
    A(2 * k - 1, :) = [x1 y1 1 0 0 0 -x1*x2 -x2*y1 -x2];
    A(2 * k, :) = [0 0 0 x1 y1 1 -y2*x1 -y1*y2 -y2];
end

%% find the homography matrix using Singular Value Decomposition
[U, S, V] = svd(A);
Homography = reshape(V(:, end), [3, 3]);
Homography = transpose(Homography);

%% transform image 2 to image 1's space
output = homography_transform(img1, Homography);
imshow(output);
