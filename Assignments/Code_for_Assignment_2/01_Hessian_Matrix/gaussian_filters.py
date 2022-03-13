import math


def gauss(x, y, s):
    gauss = (1 / (math.sqrt(2 * (math.pi)) * s)) * \
        math.exp(- ((x ** 2) + (y ** 2)) / 2 / s ** 2)
    return gauss


def gauss_1der(x, y, s, z):
    if(z == "x"):
        gauss_1der = gauss(x, y, s) * (- x / (s ** 2))
    elif(z == "y"):
        gauss_1der = gauss(x, y, s) * (- y / (s ** 2))
    return gauss_1der


def gauss_2der(x, y, s, z):
    if(z == "x"):
        gauss_2der = gauss(x, y, s) * (((x ** 2) / (s ** 2)) - 1) / s ** 2
    elif(z == "y"):
        gauss_2der = gauss(x, y, s) * (((x ** 2) / (s ** 2)) - 1) / s ** 2
    return gauss_2der
