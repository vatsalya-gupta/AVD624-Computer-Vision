function gaussian = gaussian_kernel(m, n, sigma)

[M, N] = meshgrid(-(m - 1) / 2 :(m - 1) / 2, -(n - 1) / 2 :(n - 1) / 2);
gaussian = exp(-(M .^ 2 + N .^ 2) / (2 * sigma ^ 2));
gaussian = gaussian ./ sum(gaussian(:));
