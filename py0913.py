#p.226 os.path 모듈의 경로 관련 함수 예
import os.path

os.getcwd()
os.chdir('ch8_data')
os.getcwd()
os.path.abspath('lecture/step01_try_except.py')
os.path.dirname('lecture/step01_try_except.py')
os.path.exists('D:\\Pywork\\workspace')
os.path.isfile('lecture/step01_try_except.py')
os.path.isdir('lecture')
os.path.split('c:\\test\\test1.txt')
os.path.join('c:\\test','test1.txt')
os.path.getsize('lecture/step01_try_except.py')

#p.227 glob모듈의 함수
import glob
os.getcwd()
os.chdir('C:\\Users\\tj-bu\\PycharmProjects\\pythonProject\\ch8_data\\ch8_data\\data')
glob.glob('test*.py')
glob.glob('c:/test[0-9]')
glob.glob('c:/test[0-9]/*.txt')
glob.glob('c:/test[0-9]/[0-9].*')
glob.glob('c:/test1/*.txt')
glob.glob('c:/test1/?.text')
glob.glob('c:/test1/*.txt',recursive=True)
glob.glob('./[0-9].*')

#p.229 텍스트파일 수집
import os
os.chdir('C:\\Users\\tj-bu\\PycharmProjects\\pythonProject\\ch8_data')
print(os.getcwd())
txt_data = 'ch8_data/txt_data/'
#텍스트 디렉터리 목록 반환
sub_dir =os.listdir(txt_data)
print(sub_dir)
#각 디렉터리의 텍스트 자료 수집 함수
def textPro(sub_dir) :
    first_txt =[]
    second_txt =[]
    for sdir in sub_dir :
        dirname = txt_data +'/'+sdir
        print(dirname)
        file_list = os.listdir(dirname)
        for fname in file_list :
            file_path = dirname + '/' +fname
            if os.path.isfile(file_path) :
                try:
                    file = open(file_path,'r')
                    if sdir == 'first' :
                        first_txt.append(file.read())
                    else:
                        second_txt.append(file.read())
                except Exception as e :
                    print('예외 발생 :',e)
                finally:
                    file.close()
    return first_txt, second_txt

first_txt, second_txt = textPro(sub_dir)
print('first_tex 길이 =',len(first_txt))
print('second_tex 길이 =',len(second_txt))

tot_texts = first_txt + second_txt
print('tot_texts 길이 =',len(tot_texts))

print(tot_texts)
print(type(tot_texts))

#p.232 pickle 저장 읽기 예
import pickle
pfile_w = open('ch8_data/data/tot_texts.pck', mode='wb')
pickle.dump(tot_texts, pfile_w)

pfile_r = open('ch8_data/data/tot_texts.pck', mode='rb')
tot_texts_read = pickle.load(pfile_r)
print('tot_texts 길이 =',len(tot_texts_read))
print(type(tot_texts_read))
print(tot_texts_read)

#p.233 이미지 파일 이동
import os
from glob import glob
os.chdir('C:\\Users\\tj-bu\\PycharmProjects\\pythonProject\\ch8_data')
print(os.getcwd())
img_path = 'ch8_data/images/'
img_path3 = 'ch8_data/images3/'

if os.path.exists(img_path) :
    print('해당디렉토리가 존재함')
    images =[]
    os.mkdir(img_path3)
    for pic_path in glob(img_path+'/'+'*.png') :
        img_path=os.path.split(pic_path)
        images.append(img_path[1])
        rfile = open(file=pic_path,mode='rb')
        output = rfile.read()
        wfile = open(img_path3+img_path[1],mode='wb')
        wfile.write(output)
        rfile.close()
        wfile.close()
else:
    print('해당 디렉터리가 없음')

print('png file =', images)

#p.239 패키지 추출하기
import pandas as pd
import os
print(os.getcwd())

score =pd.read_csv('ch8_data/data/score.csv')
print(score.info())
print(score.head())

kor = score.kor
eng= score['eng']
mat=score['mat']
dept=score['dept']

print('max kor =',max(kor))
print('max eng =',max(eng))
print('max mat =',max(mat))

print('min kor =', min(kor))
print('min eng =', min(eng))
print('min mat =',min(mat))

from statistics import mean
print('국어 점수 평균 :', round(mean(kor),3))
print('영어 점수 평균 :',round(mean(eng),3))
print('수학 점수 평균 :', round(mean(mat),3))

dept_count = {}

for key in dept :
    dept_count[key] =dept_count.get(key,0) +1

print(dept_count)




