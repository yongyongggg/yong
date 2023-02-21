import skimage.data
import cv2
img_astro = skimage.data.astronaut()
img_astro.shape

skimage.io.imsave("astronaut.png", img_astro)
img_astro2 = skimage.io.imread("astronaut.png")

img_astro3 = cv2.imread("./astronaut.png")
img_astro3.shape

# 각 채널을 분리
b, g, r = cv2.split(img_astro3)

# b, r을 서로 바꿔서 Merge
img_astro3_rgb = cv2.merge([r, g, b])
img_astro3_rgb.shape
img_astro3_gray = cv2.cvtColor(img_astro3, cv2.COLOR_BGR2GRAY)
img_astro3_gray.shape

import matplotlib.pyplot as plt
img_astro3_gray_resized = cv2.resize(img_astro3_gray, dsize=(50, 50))

plt.subplot(121)
plt.imshow(img_astro3_gray, cmap=plt.cm.gray)
plt.title("원본 이미지")
plt.axis("off")

plt.subplot(122)
plt.imshow(img_astro3_gray_resized, cmap=plt.cm.gray)
plt.title("축소 이미지 (같은 크기로 표현)")
plt.axis("off")

plt.show()