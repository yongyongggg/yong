#######주성분 분석

#p.2
data("iris")
head(iris)

# 변수간 상관관계 확인
cor(iris[1:4])
# 변수간 S.L와P.L, S.L와 P.W간의 상관관계 높음
# 다중공선성 문제 발생 예상
# 독립변수 새롭게 설계 필요
# 전처리 과정
iris2 <- iris[, 1:4] 
ir.species <- iris[,5] 
# 중앙을 0, 분산은 1로 설정
prcomp.result2 <- prcomp(iris2, center=T, scale=T)
prcomp.result2
# 결과
summary(prcomp.result2)
# 주성분 수 설정
plot(prcomp.result2, type="l")
# result2의 데이터 확인
prcomp.result2$rotation
iris2
# iris2 데이터와 prcomp.result2데이터를 행렬곱하여 변환
Result3 <- as.matrix(iris2) %*% prcomp.result2$rotation
# 변환결과 확인
head(Result3)
# 종 데이터와 Result3의 데이터프레임을 열병합
final2 <- cbind(ir.species, as.data.frame(Result3))
final2
# factor형으로 변환
final2[,1] <- as.factor(final2[,1])
# 컬럼명을 label1로 명명
colnames(final2)[1] <- "label1"
# final2 확인
final2
# 새로 구성된 데이터로 회귀 분석 실시
fit3 <- lm(label1 ~ PC1 + PC2, data=final2) 
fit3_pred <-predict(fit3, newdata=final2)
b2 <- round(fit3_pred)
a2 <- ir.species
table(b2,a2)

#http://contents.kocw.or.kr/KOCW/document/2015/chungbuk/najonghwa1/6.pdf
#다른 주성분 분석
data(iris)
log.ir <- log(iris[, 1:4])
ir.species <- iris[, 5]
ir.pca <- prcomp(log.ir, center = TRUE, scale. = TRUE)
print(ir.pca)
plot(ir.pca, type = "l")
summary(ir.pca)
predict(ir.pca, newdata=tail(log.ir, 2))
biplot(ir.pca)

install.packages('devtools')
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)
g <- ggbiplot(ir.pca, obs.scale=1, var.scale=1, groups=ir.species, ellipse=TRUE, circle=TRUE)      
g <- g + scale_color_discrete(name='') 
g <- g + theme(legend.direction='horizontal', legend.position='top')
print(g)

require(ggplot2)
theta <- seq(0,2*pi,length.out = 100)
circle <- data.frame(x = cos(theta), y = sin(theta))
p <- ggplot(circle,aes(x,y)) + geom_path()
loadings <- data.frame(ir.pca$rotation, .names = row.names(ir.pca$rotation))
p + geom_text(data=loadings, 
              mapping=aes(x = PC1, y = PC2, label = .names, colour = .names)) +
  coord_fixed(ratio=1) +labs(x = "PC1", y = "PC2")

install.packages('caret')
install.packages('recipes')
library(recipes)
require(caret)
trans = preProcess(iris[,1:4], method=c("BoxCox", "center", "scale", "pca")) 
PC = predict(trans, iris[,1:4])
head(PC, 3)  
trans$rotation
