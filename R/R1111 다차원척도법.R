##########다차원 척도법

install.packages("MASS")
library(MASS)
data("eurodist")
eurodist

# 다차원 척도법 적용
MDSeurodist <- cmdscale(eurodist)
MDSeurodist

# 시각화
plot(MDSeurodist) 
text(MDSeurodist, rownames(MDSeurodist), cex=0.8, col="blue")
abline(v=0, h=0, lty=1, lwd=0.5)



#p.5
install.packages("HSAUR")
library(HSAUR)
library(MASS)

data("voting", package="HSAUR")
voting

MDS2voting <- isoMDS(voting) 
MDS2voting 

x <- MDS2voting$point[,1]
y <- MDS2voting$point[,2]
plot(x,y) 
text(x, y, labels= colnames(voting))
