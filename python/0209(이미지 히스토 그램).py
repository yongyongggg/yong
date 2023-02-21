import cv2
from skimage.data import camera
import matplotlib.pylab as plt
img = camera()

hist = cv2.calcHist([img], [0], None, [256], [0, 256])

plt.subplot(121)
plt.imshow(img, "gray")
plt.axis("off")
plt.subplot(122)
plt.plot(hist, color='r')
plt.xlim([0, 256])
plt.tight_layout()
plt.show()


from skimage.data import camera
img = camera()

rows, cols = img.shape
H = cv2.getRotationMatrix2D((cols/2, rows/2), 90, 0.7)
img_rotated = cv2.warpAffine(img, H, (cols, rows))
sift = cv2.xfeatures2d.SIFT_create()
kps, des = sift.detectAndCompute(img, None)
kps_r, des_r = sift.detectAndCompute(img_rotated, None)
kp0 = kps[0]
print("pt=({},{}), size={}, angle={}".format(kp0.pt[0], kp0.pt[1], kp0.size, kp0.angle))

import numpy as np
plt.rc('font', family='Malgun Gothic')
bf = cv2.BFMatcher_create()
matches = bf.knnMatch(des, des_r, k=2)

good = []
for m, n in matches:
    if m.distance < 0.4 * n.distance:
        good.append([m])

np.random.shuffle(good)
image_match = cv2.drawMatchesKnn(
    img, kps, img_rotated, kps_r, good[:10], flags=2, outImg=img)

pts_x = [kp.pt[0] for kp in kps]
pts_y = [kp.pt[1] for kp in kps]
pts_s = [kp.size for kp in kps]

plt.imshow(img, cmap="gray")
plt.title("SIFT 특징점")
plt.axis("off")
plt.scatter(pts_x, pts_y, s=pts_s, c="w")
plt.show()

plt.bar(np.arange(len(des[0])), des[0])
plt.xticks(range(0, len(des[0]), 8))
plt.yticks([des[0].min(), des[0].mean(), des[0].max()])
plt.title("첫번째 특징점의 설명자")
plt.show()

plt.imshow(image_match)
plt.title("SIFT 특징점 매칭")
plt.axis("off")
plt.show()

surf = cv2.xfeatures2d.SURF_create(400)
kps, des = surf.detectAndCompute(img, None)
kps_r, des_r = surf.detectAndCompute(img_rotated, None)

kp0 = kps[0]
print("pt=({},{}), size={}, angle={}".format(kp0.pt[0], kp0.pt[0], kp0.size, kp0.angle))


fast = cv2.FastFeatureDetector_create()
kps = fast.detect(img, None)
img2 = cv2.drawKeypoints(img, kps, img, color=(255, 255, 255))

print("기준값: ", fast.getThreshold())
print("nonmaxSuppression: ", fast.getNonmaxSuppression())
print("nonmaxSuppression 후처리 후, 추출된 전체 특징점: ", len(kps))
plt.figure(figsize=(7,7))
plt.imshow(img2, cmap='gray')
plt.title("FAST 로 찾은 Corner")
plt.axis("off")
plt.show()

orb = cv2.ORB_create()
kps, des = orb.detectAndCompute(img, None)
kps_r, des_r = orb.detectAndCompute(img_rotated, None)

bf = cv2.BFMatcher_create()
matches = bf.knnMatch(des, des_r, k=2)

good = []
for m, n in matches:
    if m.distance < 0.4 * n.distance:
        good.append([m])

np.random.shuffle(good)
image_match = cv2.drawMatchesKnn(
    img, kps, img_rotated, kps_r, good[:10], flags=2, outImg=img)

pts_x = [kp.pt[0] for kp in kps]
pts_y = [kp.pt[1] for kp in kps]
pts_s = [kp.size / 10 for kp in kps]


plt.imshow(img, cmap='gray')
plt.title("ORB 특징점")
plt.axis("off")
plt.scatter(pts_x, pts_y, s=pts_s, c="w")
plt.show()

plt.bar(np.arange(len(des[0])), des[0])
plt.xticks(range(0, len(des[0]), 8))
plt.yticks([des[0].min(), des[0].mean(), des[0].max()])
plt.title("첫번째 특징점의 설명자")
plt.show()

plt.imshow(image_match)
plt.title("ORB 특징점 매칭")
plt.axis("off")
plt.show()