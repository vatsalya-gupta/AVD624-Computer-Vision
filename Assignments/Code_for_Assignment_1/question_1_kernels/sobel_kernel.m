function [sobel_x, sobel_y] = sobel_kernel(kernel_size)

if kernel_size == 3
    sobel_y = [1 0 -1; 2 0 -2; 1 0 -1];
else
    sobel_y = [2 1 0 -1 -2; 2 1 0 -1 -2; 4 2 0 -2 -4; 2 1 0 -1 -2; 2 1 0 -1 -2;];
end

sobel_x = sobel_y';
