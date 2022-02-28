function stitched_image = stitch_two_images(img1, img2, offset)

x_img1 = size(img1, 2);
x_img2 = size(img2, 2);
y_img1 = size(img1, 1);
y_img2 = size(img2, 1);

offset_in_x = offset(1);
offset_in_y = offset(2);

%% size of the figure
if offset_in_x >= 0
    x_draw = max(x_img2,  offset_in_x + x_img1);
else
    x_draw = max(x_img2, offset_in_x + x_img1) - offset_in_x;
end

if offset_in_y >= 0
    y_draw = max(y_img2, offset_in_y + y_img1);
else
    y_draw = max(y_img2, offset_in_y + y_img1) - offset_in_y;
end

%% empty figures of same size for both of the images
draw1 = zeros(y_draw, x_draw, 3);
draw2 = zeros(y_draw, x_draw, 3);

%% relative position of the images
if offset_in_x > 0 && offset_in_y > 0
    draw1(offset_in_y + 1 : y_img1 + offset_in_y, offset_in_x + 1 : x_img1 + offset_in_x, :) = img1(:, :, :);
    draw2(1 : y_img2, 1 : x_img2, :) = img2(:, :, :);
    
elseif offset_in_x > 0 && offset_in_y < 0
    draw1(1 : y_img1, offset_in_x + 1 : x_img1 + offset_in_x, :) = img1(:, :, :);
    draw2(1 - offset_in_y : y_img2 - offset_in_y, 1 : x_img2, :) = img2(:, :, :);
    
elseif offset_in_x < 0 && offset_in_y > 0
    draw1(offset_in_y + 1 : y_img1 + offset_in_y, 1 : x_img1, :) = img1(:, :, :);
    draw2(1 : y_img2, 1 - offset_in_x : x_img2 - offset_in_x, :) = img2(:, :, :);
    
elseif offset_in_x < 0 && offset_in_y < 0
    draw1(1 : y_img1, 1 : x_img1, :) = img1(:, :, :);
    draw2(1 - offset_in_y : y_img2 - offset_in_y, 1 - offset_in_x : x_img2 - offset_in_x, :) = img2(:, :, :);
    
end

stitched_image = uint8(max(draw1, draw2));
