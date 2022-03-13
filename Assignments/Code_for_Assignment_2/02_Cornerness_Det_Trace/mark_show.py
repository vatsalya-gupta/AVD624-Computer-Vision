from matplotlib import cm, pyplot as plt


def mark_show_hess(I,  # input image
                   x,  # x vertex of corner
                   y  # y vertex of corner
                   ):
    plt.figure()
    plt.imshow(I, cmap=cm.gray)  # plots the image in greyscale
    plt.plot(x, y, "r.")  # mark the corners in red
    plt.axis([0, len(I[0, :]), len(I[:, 0]), 0])
    return plt.show()


def mark_show_cor(I,  # input image
                  x,  # x vertex of corner
                  y  # y vertex of corner
                  ):
    plt.figure()
    plt.imshow(I, cmap=cm.gray)  # plots the image in greyscale
    plt.plot(x, y, "r.")  # mark the corners in red
    plt.axis([5, len(I[0, :]), len(I[:, 0]), 5])
    return plt.show()
