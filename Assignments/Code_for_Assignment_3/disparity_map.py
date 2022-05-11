import cv2
import matplotlib.pyplot as plt

leftImg = cv2.imread('left.jpg', 0)
rightImg = cv2.imread('right.jpg', 0)

stereoMatrix = cv2.StereoBM_create(numDisparities = 64, blockSize = 15)
disparityMap = stereoMatrix.compute(leftImg, rightImg)
plt.imshow(disparityMap, 'gray')
plt.show()