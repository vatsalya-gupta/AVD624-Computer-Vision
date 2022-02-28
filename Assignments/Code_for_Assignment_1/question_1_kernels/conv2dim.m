function conv_output = conv2dim(img, kernel)

[row_ker, col_ker] = size(kernel);
[row_img, col_img] = size(img);

loc_y = floor(col_ker / 2) + 1 : floor(col_ker / 2) + col_img;
loc_x = floor(row_ker / 2) + 1 : floor(row_ker / 2) + row_img;

padding = zeros(row_img + row_ker, col_img + col_ker);
padding(loc_x, loc_y) = img;

conv_output = zeros(row_img, col_img);
for i_img = 1 : row_img
    for j_img = 1 : col_img
        for i_ker = 1 : row_ker
            for j_ker = 1 : col_ker
                conv_update = sum(sum(padding(i_img + i_ker - 1, j_img + j_ker - 1) * kernel(row_ker - i_ker + 1, col_ker - j_ker + 1)));
                conv_output(i_img, j_img) = conv_output(i_img, j_img) + conv_update;
            end
        end
    end
end
