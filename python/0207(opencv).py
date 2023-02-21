import sys
import cv2

print('Hello OpenCV', cv2.__version__)
img = cv2.imread('lenna.bmp')

if img is None:
    print('Image load failed!')
    sys.exit()


cv2.namedWindow('image2')
cv2.imshow('image2', img)
cv2.waitKey()
cv2.destroyAllWindows()

