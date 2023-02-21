import cv2

img_file = "./img1/girl.jpg"
img = cv2.imread(img_file)
title = 'IMG'                   # 창 이름
x, y = 100, 100                 # 최초 좌표

while True:
    cv2.imshow(title, img)
    cv2.moveWindow(title, x, y)
    key = cv2.waitKey(0) & 0xFF # 키보드 입력을 무한 대기, 8비트 마스크처리
    print(key, chr(key))        # 키보드 입력 값,  문자 값 출력
    if key == ord('h'):         # 'h' 키 이면 좌로 이동
        x -= 10
    elif key == ord('j'):       # 'j' 키 이면 아래로 이동
        y += 10
    elif key == ord('k'):       # 'k' 키 이면 위로 이동
        y -= 10
    elif key == ord('l'):       # 'l' 키 이면 오른쪽으로 이동
        x += 10
    elif key == ord('q') or key == 27: # 'q' 이거나 'esc' 이면 종료
        break
        cv2.destroyAllWindows()
    cv2.moveWindow(title, x, y )   # 새로운 좌표로 창 이동


import cv2
import numpy as np

win_name = 'Trackbar'                                   # 창 이름

img = cv2.imread('./img1/blank_500.jpg')
cv2.imshow(win_name,img)                                # 초기 이미지를 창에 표시

# 트랙바 이벤트 처리 함수 선언 ---①
def onChange(x):
    print(x)                                            # 트랙바 새로운 위치 값
    # 'R', 'G', 'B' 각 트랙바 위치 값    --- ③
    r = cv2.getTrackbarPos('R',win_name)
    g = cv2.getTrackbarPos('G',win_name)
    b = cv2.getTrackbarPos('B',win_name)
    print(r, g, b)
    img[:] = [b,g,r]                                    # 기존 이미지에 새로운 픽셀 값 적용
    cv2.imshow(win_name, img)                           # 새 이미지 창에 표시

# 트랙바 생성    --- ⑤
cv2.createTrackbar('R', win_name, 255, 255, onChange)
cv2.createTrackbar('G', win_name, 255, 255, onChange)
cv2.createTrackbar('B', win_name, 255, 255, onChange)

while True:
    if cv2.waitKey(1) & 0xFF == 27:
        break
cv2.destroyAllWindows()