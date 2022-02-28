function [output_img, min_x, min_y]  = homography_transform(input_img, Homography)

size_x = size(input_img, 2);
size_y = size(input_img, 1);

%% define the corner points
top_left = [1; 1; 1];
top_right = [size_x; 1; 1];
bottom_left = [1; size_y; 1];
bottom_right = [size_x; size_y; 1];

canvas = cat(2, top_left, top_right, bottom_left, bottom_right);
updated_canvas = Homography * canvas;

%% location of corner points after the homography transform
updated_canvas_cartesian = updated_canvas(1 : 2, :) ./ updated_canvas(3, :);

%% determine size of the output image
max_x = ceil(max(updated_canvas_cartesian(1, :)));
min_x = floor(min(updated_canvas_cartesian(1, :)));
max_y = ceil(max(updated_canvas_cartesian(2, :)));
min_y = floor(min(updated_canvas_cartesian(2, :)));
new_size_x = max_x - min_x;
new_size_y = max_y - min_y;

output_img = zeros(new_size_y, new_size_x, 3, 'uint8');

%% function_map of coordinate
[x, y] = meshgrid(linspace(1, new_size_x, new_size_x), linspace(1, new_size_y, new_size_y));
function_map = [reshape(x, [], 1), reshape(y, [], 1), ones(new_size_x * new_size_y, 1)];
function_map = function_map + [min_x min_y 0];

%% corresponding location on input image for every pixel of the output image
reference_location = Homography \ transpose(function_map);
reference_location_in_cartesian = reference_location(1 : 2, :) ./ reference_location(3, :);

for i = 1 : 3
    magnitude = interp2(double(input_img(:, :, i)), reference_location_in_cartesian(1, :), reference_location_in_cartesian(2, :));
    output_img(:, :, i) = uint8(reshape(magnitude, [new_size_y, new_size_x]));
end
