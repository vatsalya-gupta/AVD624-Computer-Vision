import math
import time

from matplotlib import cm, pyplot as plt
from numpy import array, convolve, linalg, matrix, trace, transpose
from PIL import Image

from gaussian_filters import gauss, gauss_1der, gauss_2der
from mark_show import mark_show_hess


def hessian(img,  # the input image name
            scale,  # standard Deviation value
            threshold  # threshold of eigen value to be considered as edge
            ):
    begin = time.time()
    size = 2  # kernel size = 2*(size) + 1
    I = array(Image.open(img).convert("L"))  # reads the input image into I

    # Gaussian along x
    Gx = []
    for i in range(- size, size + 1):
        Gx.append(gauss_1der(i, 0, scale, "x"))

    # Gaussian along y
    Gy = []
    for i in range(- size, size + 1):
        Gy.append([gauss_1der(0, i, scale, "y")])

    Gx2 = []
    for i in range(- size, size + 1):
        Gx2.append(gauss_2der(i, 0, scale, "x"))

    Gy2 = []
    for i in range(- size, size + 1):
        Gy2.append([gauss_2der(0, i, scale, "y")])

    # I*G along x
    Ix = []
    for i in range(len(I[:, 0])):
        Ix.extend([convolve(I[i, :], Gx)])
    Ix = array(matrix(Ix))

    # I*G along y
    Iy = []
    for i in range(len(I[0, :])):
        Iy.extend([convolve(I[:, i], Gx)])
    Iy = array(matrix(transpose(Iy)))

    # Ix*Gx along x
    Ixx = []
    for i in range(len(Ix[:, 0])):
        Ixx.extend([convolve(Ix[i, :], Gx2)])
    Ixx = array(matrix(Ixx))

    # Iy*Gy in y direction
    Iyy = []
    for i in range(len(Iy[0, :])):
        Iyy.extend([convolve(Ix[:, i], Gx2)])
    Iyy = array(matrix(transpose(Iyy)))

    Ixy = []
    for i in range(len(Iy[0, :])):
        Ixy.extend([convolve(Ix[:, i], Gx2)])
    Ixy = array(matrix(transpose(Ixy)))

    x = []  # x vertices of the corners
    y = []  # y vertices of the corners
    for i in range(len(I[:, 0])):
        for j in range(len(I[0, :])):
            H1 = linalg.eigvals(
                ([Ixx[i, j], Ixy[i, j]], [Ixy[i, j], Iyy[i, j]]))
            if((abs(H1[0]) > threshold) & (abs(H1[1]) > threshold)):  # check corner condition
                y.append(i - 2)
                x.append(j - 2)

    mark_show_hess(I, x, y)
    return time.time() - begin


img1 = hessian("../input_images/bicycle.bmp", scale=1, threshold=21)
img2 = hessian("../input_images/bird.bmp", scale=1, threshold=12)
img3 = hessian("../input_images/dog.bmp", scale=1, threshold=6)
img4 = hessian("../input_images/einstein.bmp", scale=1, threshold=15)
img5 = hessian("../input_images/plane.bmp", scale=1, threshold=10)
img6 = hessian("../input_images/toy_image.jpg", scale=1, threshold=38)

print("Execution time:\nImage 1: %.2fseconds\nImage 2: %.2fseconds\nImage 3: %.2fseconds\nImage 4: %.2fseconds\nImage 5: %.2fseconds\nImage 6: %.2fseconds)" %
      (img1, img2, img3, img4, img5, img6))
