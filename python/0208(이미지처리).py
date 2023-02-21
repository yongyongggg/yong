import scipy as sp

img_gray = sp.misc.face(gray=True)
img_gray.shape

import matplotlib.pylab as plt
import seaborn as sns

sns.heatmap(img_gray[:15, :15], annot=True, fmt="d", cmap=plt.cm.bone)
plt.axis("off")
plt.show()

from sklearn.datasets import load_sample_images

dataset = load_sample_images()
img_rgb = dataset.images[1]
img_rgb.shape

plt.figure(figsize=(10, 2))

plt.subplot(141)
plt.imshow(img_rgb[:, :, :])
plt.axis("off")
plt.title("RGB")

plt.subplot(142)
plt.imshow(img_rgb[:, :, 0], cmap=plt.cm.bone)
plt.axis("off")
plt.title("R")

plt.subplot(143)
plt.imshow(img_rgb[:, :, 1], cmap=plt.cm.bone)
plt.axis("off")
plt.title("G")

plt.subplot(144)
plt.imshow(img_rgb[:, :, 2], cmap=plt.cm.bone)
plt.axis("off")
plt.title("B")

plt.show()

from matplotlib.colors import hsv_to_rgb
import numpy as np

V, H = np.mgrid[0:1:100j, 0:1:360j]
S = np.ones_like(V)

HSV_S100 = np.dstack((H, S * 1.0, V))
RGB_S100 = hsv_to_rgb(HSV_S100)
HSV_S20 = np.dstack((H, S * 0.2, V))
RGB_S20 = hsv_to_rgb(HSV_S20)

HSV_S20.shape

# 색상(Hue)
HSV_S20[:4, :5, 0]

# 채도(Saturation)
HSV_S20[:4, :5, 1]

# 명도(Value)
HSV_S20[:4, :5, 2]

import matplotlib
matplotlib.font_manager._rebuild()
import matplotlib.pyplot as plt
plt.rc('font', family='Malgun Gothic')

plt.rc('axes', unicode_minus=False)
plt.subplot(211)
plt.imshow(RGB_S100, origin="lower", extent=[0, 360, 0, 1], aspect=80)
plt.xlabel("색상(Hue)")
plt.ylabel("명도(Value)")
plt.title("채도(Saturation) 100일 때의 색공간")
plt.grid(False)

plt.subplot(212)
plt.imshow(RGB_S20, origin="lower", extent=[0, 360, 0, 1], aspect=80)
plt.xlabel("색상(Hue)")
plt.ylabel("명도(Value)")
plt.title("채도(Saturation) 20일 때의 색공간")
plt.grid(False)

plt.tight_layout()
plt.show()