function normed_img = norm_upto_255(img)

min_pixel = 0;
max_pixel = 255;
min_img = min(min(img));
max_img = max(max(img));

normed_img = min_pixel + (max_pixel-min_pixel) * (img - min_img) / (max_img - min_img);
