import math
import time

from matplotlib import cm, pyplot as plt
from numpy import array, convolve, linalg, matrix, trace, transpose
from PIL import Image

from gaussian_filters import gauss, gauss_1der
from mark_show import mark_show_cor


def Harris(img,  # input image
           size,  # kernel size = 2(size) + 1
           a,  # alpha
           threshold,
           scale
           ):

    start = time.time()
    inp = img
    I = array(Image.open(inp).convert('L'))
    G = []
    for i in range(-size, size+1):
        G.append(gauss(i, 0, scale))

    # Gaussian along x
    Gx = []
    for i in range(-size, size+1):
        Gx.append(gauss_1der(i, 0, scale, 'x'))

    # Gaussian along y
    Gy = []
    for i in range(-size, size+1):
        Gy.append([gauss_1der(0, i, scale, 'y')])

    # I*G along x
    I1 = []
    for i in range(len(I[:, 0])):
        I1.extend([convolve(I[i, :], G)])
    I1 = array(matrix(I1))
    I11 = I1*I1

    # I*G along x
    Ix = []
    for i in range(len(I[:, 0])):
        Ix.extend([convolve(I1[i, :], Gx)])
    Ix = array(matrix(Ix))

    # I*G along y
    I2 = []
    for i in range(len(I[0, :])):
        I2.extend([convolve(I[:, i], G)])
    I2 = array(matrix(transpose(I2)))
    I22 = I2*I2

    # I*G along y
    Iy = []
    for i in range(len(I[0, :])):
        Iy.extend([convolve(I2[:, i], Gx)])
    Iy = array(matrix(transpose(Iy)))

    I12 = []
    for i in range(len(I1[:, 0])):
        temp = []
        for j in range(len(I2[0, :])):
            temp.append(I1[i, j]*I2[i, j])
        if (j == len(I2[0, :])-1):
            I12.extend(array(matrix(temp)))
    I12 = array(matrix(I12))

    Ixy = []
    for i in range(len(I12[:, 0])):
        Ixy.extend([convolve(I12[i, :], Gx)])
    Ixy = array(matrix(Ixy))

    x = []
    y = []
    for i in range(len(I[:, 0])):
        for j in range(len(I[0, :])):
            H1 = ([Ix[i, j]**2, Ix[i, j]*Iy[i, j]],
                  [Ix[i, j]*Iy[i, j], Iy[i, j]**2])  # Harris matrix
            # Cornerness measure in terms of eigenvalues
            e, v = linalg.eig(H1)
            if((abs((e[0]*e[1])-(a*(e[0]+e[1])))) > threshold):
                y.append(i-5)
                x.append(j-5)

    mark_show_cor(I, x, y)
    return time.time() - start


img1 = Harris('../input_images/bicycle.bmp', size=2, a=.06, threshold=12, scale=2)
img2 = Harris('../input_images/bird.bmp', size=2, a=.06, threshold=3, scale=2)
img3 = Harris('../input_images/dog.bmp', size=2, a=.06, threshold=1, scale=2)
img4 = Harris('../input_images/einstein.bmp', size=2, a=.06, threshold=6, scale=2)
img5 = Harris('../input_images/plane.bmp', size=2, a=.06, threshold=4, scale=2)
img6 = Harris('../input_images/toy_image.jpg', size=2, a=.06, threshold=15, scale=2)

print("Execution time:\nImage 1: %.2fseconds\nImage 2: %.2fseconds\nImage 3: %.2fseconds\nImage 4: %.2fseconds\nImage 5: %.2fseconds\nImage 6: %.2fseconds)" %
      (img1, img2, img3, img4, img5, img6))
