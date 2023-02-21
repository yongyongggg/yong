import cv2

img_file = "./img1/girl.jpg"  # 표시할 이미지 경로            ---①
img = cv2.imread(img_file)  # 이미지를 읽어서 img 변수에 할당 ---②

if img is not None:
    cv2.imshow('IMG', img)  # 읽은 이미지를 화면에 표시      --- ③
    cv2.waitKey()  # 키가 입력될 때 까지 대기      --- ④
    cv2.destroyAllWindows()  # 창 모두 닫기            --- ⑤
else:
    print('No image file.')


import cv2

cap = cv2.VideoCapture(0)               # 0번 카메라 장치 연결 ---①
if cap.isOpened():                      # 캡쳐 객체 연결 확인
    while True:
        ret, img = cap.read()           # 다음 프레임 읽기
        if ret:
            cv2.imshow('camera', img)   # 다음 프레임 이미지 표시
            if cv2.waitKey(1) != -1:    # 1ms 동안 키 입력 대기 ---②
                break                   # 아무 키라도 입력이 있으면 중지
        else:
            print('no frame')
            break
else:
    print("can't open camera.")
cap.release()                           # 자원 반납
cv2.destroyAllWindows()


import cv2

cap = cv2.VideoCapture(0)                   # 카메라 0번 장치 연결
width = cap.get(cv2.CAP_PROP_FRAME_WIDTH)   # 프레임 폭 값 구하기
height = cap.get(cv2.CAP_PROP_FRAME_HEIGHT) # 프레임 높이 값 구하기
print("Original width: %d, height:%d" % (width, height) )

cap.set(cv2.CAP_PROP_FRAME_WIDTH, 320)      # 프레임 폭을 320으로 설정
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 240)     # 프레임 높이를 240으로 설정
width = cap.get(cv2.CAP_PROP_FRAME_WIDTH)   # 재지정한 프레임 폭 값 구하기
height = cap.get(cv2.CAP_PROP_FRAME_HEIGHT) # 재지정한 프레임 폭 값 구하기

print("Resized width: %d, height:%d" % (width, height) )
if cap.isOpened():
    while True:
        ret, img = cap.read()
        if ret:
            cv2.imshow('camera', img)
            if cv2.waitKey(1) != -1:
                break
        else:
            print('no frame!')
            break
else:
    print("can't open camera!")
cap.release()
cv2.destroyAllWindows()


import cv2

file_path = './img1/girl.jpg'
img = cv2.imread(file_path)                            # 이미지를 기본 값으로 읽기
img_gray = cv2.imread(file_path, cv2.IMREAD_GRAYSCALE) # 이미지를 그레이 스케일로 읽기

cv2.namedWindow('origin')                               # origin 이름으로 창 생성
cv2.namedWindow('gray', cv2.WINDOW_NORMAL)              # gray 이름으로 창 생성
cv2.imshow('origin', img)                               # origin 창에 이미지 표시
cv2.imshow('gray', img_gray)                            # gray 창에 이미지 표시

cv2.moveWindow('origin', 0, 0)                          # 창 위치 변경
cv2.moveWindow('gray', 100, 100)                        # 창 위치 변경

cv2.waitKey(0)                                          # 아무키나 누르면
cv2.resizeWindow('origin', 200, 200)                    # 창 크기 변경 (변경 안됨)
cv2.resizeWindow('gray', 100, 100)                      # 창 크기 변경 (변경 됨))

cv2.waitKey(0)                                          # 아무키나 누르면
cv2.destroyWindow("gray")                               # gray 창 닫기

cv2.waitKey(0)                                          # 아무키나 누르면
cv2.destroyAllWindows()                                 # 모든 창 닫기