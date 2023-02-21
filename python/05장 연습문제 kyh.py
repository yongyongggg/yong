######05장 연습문제
#김용현

#문제1
height = int(input('height : '))
def StarCount(height) :
    cnt = 0
    for i in range(1,height+1) :
        print(i*'*')
        cnt = cnt+i
    print('start 개수 : %d'%cnt)

StarCount(height)



#문제 2
bal = int(input('최초 계좌의 잔액을 입력하세요 : '))
def bank_account(bal) :
    balance = bal
    def getBalance() :
        return balance
    def depoit(money) :
        nonlocal balance
        balance = balance + money
        return balance
    def withdraw(money) :
        nonlocal balance
        if balance >= money :
            balance= balance - money
            return balance
        else :
            balance = balance -money
            print('잔액이 부족합니다.')
            return balance
    return getBalance, depoit, withdraw

getBalance, depoit, withdraw = bank_account(bal)
print('현재 계좌 잔액은 :',getBalance(),'원 입니다.')
money=int(input('입금액을 입력하세요 : '))
print(money,'원 입금 후 잔액은 ',depoit(money),'원 입니다.')
money1= int(input('출금액을 입력하세요 :'))
print(money1,'원 출금 후 잔액은',withdraw(money1),'원 입니다.')

#수정
bal = int(input('최초 계좌의 잔액을 입력하세요 : '))
def bank_account(bal) :
    balance = bal
    def getBalance() :
        return balance
    def depoit(money) :
        nonlocal balance
        balance = balance + money
        print(money, '원 입금 후 잔액은 ', balance, '원 입니다.')
    def withdraw(money) :
        nonlocal balance
        if balance >= money :
            balance= balance - money
            print(money, '원 출금 후 잔액은', balance, '원 입니다.')
        else :
            print('잔액이 부족합니다.')
    return getBalance, depoit, withdraw

getBalance, depoit, withdraw = bank_account(bal)
print('현재 계좌 잔액은 :',getBalance(),'원 입니다.')
money=int(input('입금액을 입력하세요 : '))
depoit(money)
money1= int(input('출금액을 입력하세요 :'))
withdraw(money1)

#문제3
def Factorial(n) :
    if n ==1 :
        return 1
    else :
        result_fact = n*Factorial(n-1)
        return result_fact

result_fact = Factorial(5)
print('팩토리얼 결과:',result_fact)






