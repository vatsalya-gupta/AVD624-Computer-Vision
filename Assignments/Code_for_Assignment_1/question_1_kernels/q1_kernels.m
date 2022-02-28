%% Part 1: 2D Convolution
close all; clear; clc;

%% load the image and covert to grayscale double
name_img = 'im01.jpg';
orig_img = imread(name_img);
orig_img = im2gray(orig_img);
img = double(orig_img);

%% display the original image
figure
imshow(orig_img);
title('Original image');

%% Gaussian kernel (m x n)
m = 3; n = 3; sigma = 5;
gaussian = gaussian_kernel(m, n, sigma);

%% Sobel kernel
kernel_size = 3; % 3 or 5
[sobel_x, sobel_y] = sobel_kernel(kernel_size);

%% Haar-like masks
scale = 5;
haar1 = imresize([1; -1], scale, 'nearest');
haar2 = imresize([1, -1], scale, 'nearest');
haar3 = imresize([1, -2, 1], scale, 'nearest');
haar4 = imresize([1; -2; 1], scale, 'nearest');
haar5 = imresize([1, -1; -1, 1], scale, 'nearest');

%% Gaussian filtering
output_gaussian = conv2dim(img, gaussian);
output_gaussian = norm_upto_255(output_gaussian);

figure
imshow(output_gaussian, [0, 255]);
title(['Gaussian filter (m = ' num2str(m) ', n = ' num2str(n) ', σ = ' num2str(sigma) ')']);

%% Sobel filtering
output_sobel_x = norm_upto_255(conv2dim(img, sobel_x));
output_sobel_y = norm_upto_255(conv2dim(img, sobel_y));
output_sobel = norm_upto_255(sqrt(output_sobel_y .^ 2 + output_sobel_x .^ 2));

figure
subplot(2, 2, 1);
imshow(orig_img);
title('Original image');

subplot(2, 2, 2);
imshow(output_sobel_x, [0, 255]);
title(['Sobel vertical filter ' num2str(kernel_size) 'x' num2str(kernel_size)]);

subplot(2, 2, 3);
imshow(output_sobel_y, [0, 255]);
title(['Sobel horizonal filter ' num2str(kernel_size) 'x' num2str(kernel_size)]);

subplot(2, 2, 4);
imshow(output_sobel, [0, 255]);
title(['Gradient magnitude ' num2str(kernel_size) 'x' num2str(kernel_size)]);

%% Haar-like masks
output_haar1 = norm_upto_255(conv2dim(img, haar1));
output_haar2 = norm_upto_255(conv2dim(img, haar2));
output_haar3 = norm_upto_255(conv2dim(img, haar3));
output_haar4 = norm_upto_255(conv2dim(img, haar4));
output_haar5 = norm_upto_255(conv2dim(img, haar5));

figure
subplot(2, 3, 1);
imshow(orig_img);
title('Original image');

subplot(2, 3, 2);
imshow(output_haar1, [0, 255]);
title('Haar 1');

subplot(2, 3, 3);
imshow(output_haar2, [0, 255]);
title('Haar 2');

subplot(2, 3, 4);
imshow(output_haar3, [0, 255]);
title('Haar 3');

subplot(2, 3, 5);
imshow(output_haar4, [0, 255]);
title('Haar 4');

subplot(2, 3, 6);
imshow(output_haar5, [0, 255]);
title('Haar 5');
