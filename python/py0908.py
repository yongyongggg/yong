#p.213 예외처리
print('프로그램 시작!!!!')
x =[10,30,25.2,'num',14,51]

for i in x :
    print(i)
    y = i**2
    print('y = ',y)

print('프로그램 종료')
#예외처리하기
print('프로그램 시작!!!!')
x = [10, 30, 25.2, 'num', 14, 51]

for i in x:
    try:
        y = i ** 2
        print('i=',i,'y=',y)
    except :
        print('숫자 아님 :', i)

print('프로그램 종료')

#p.215
print('\n유형별 예외처리')
try :
    div =1000 /2.53
    print('div = %5.2f'%(div))
    div = 1000/0
    f = open('c:\\test.txt')
    num = int(input('숫자 입력 :'))
    print('num =',num)
except ZeroDivisionError as e : #산술적 예외 처리
    print('오류정보 :',e)
except FileNotFoundError as e : #파일 열기 예외처리
    print('오류정보 :', e)
except Exception as e : #유형별 예외 처리
    print('오류정보 :', e)
finally:
    print('finally 영역 - 항상 실행되는 영역')

#p.218 텍스트 파일 입출력
import os
print('\n현재 경로 :', os.getcwd())

try :
    ftest1 = open('ch8_data/ch8_data/data/ftest.txt',mode='r')
    print(ftest1.read())
    ftest2 = open('ch8_data/ch8_data/data/ftest2.txt',mode='w')
    ftest2.write('my first text ~~~')
    ftest3 = open('ch8_data/ch8_data/data/ftest2.txt',mode='a')
    ftest3.write('\nmy second text ~~~')
except Exception as e :
    print('Error 발생 : ',e)
finally:
    ftest1.close()
    ftest2.close()
    ftest3.close()

#p.220 텍스트 자료 읽기
try :
    # read() : 전체 텍스트 자료 읽기
    ftest = open('ch8_data/ch8_data/data/ftest.txt',mode='r')
    full_text = ftest.read()
    print(full_text)
    print(type(full_text))
    # readlines() : 전체 텍스트 줄 단위 읽기
    ftest = open('ch8_data/ch8_data/data/ftest.txt',mode='r')
    lines = ftest.readlines()
    print(lines)
    print(type(lines))
    print('문단 수 :',len(lines))
    #list 문장 추출
    docs = []
    for line in lines :
        print(line.strip()) #텍스트만 출력
        docs.append(line.strip())
    print(docs)

    # readline () : 한줄 읽기
    ftest = open('ch8_data/ch8_data/data/ftest.txt',mode='r')
    line = ftest.readline()
    print(line)
    print(type(line))
except Exception as e :
    print('Error 발생 :', e)
finally:
    ftest.close()

#p.222 with 블록과 인코딩 방식
try :
    with open('ch8_data/ch8_data/data/ftest3.txt',mode='w',encoding='utf-8') as ftest :
        ftest.write('파이썬 파일 작성 연습')
        ftest.write('\n파이썬 파일 작성 연습2')
        #with 블록 벗어나면 자동 close
    with open('ch8_data/ch8_data/data/ftest3.txt',mode='r',encoding='utf-8') as ftest :
        print(ftest.read())
except Exception as e :
    print('Error 발생 :',e)
finally:
    pass

#p.224
import os
#현재 작업 디렉터리 경로 확인
os.getcwd()

#작업 디렉토리 변경
os.chdir('chater08')
os.getcwd()

#현재 작업 디렉토리 목록
os.listdir('.')

#작업 디렉토리 생성
os.mkdir('test')
os.listdir('.')

#디렉토리 이동
os.chdir('test')
os.getcwd()

#여러 디렉터리 생성
os.makedirs('test2/test3')
os.listdir('.')

#디렉터리 이동
os.chdir('test2')
os.listdir('.')

#디렉토리 삭제
os.rmdir('test3')
os.listdir('.')

#상위 디렉터리 이동
os.chdir('../..')
os.getcwd()

#여러개의 디렉터리 삭제
os.removedirs('test/test2')




