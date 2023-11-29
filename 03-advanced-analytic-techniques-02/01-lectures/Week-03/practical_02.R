# 导入必备的package
library(gRain)

# 运行代码
yn <- c("yes","no")
a <- cptable(~asia, values=c(1,99),levels=yn)
t.a <- cptable(~tub|asia, values=c(5,95,1,99),levels=yn)
s <- cptable(~smoke, values=c(5,5), levels=yn)
l.s <- cptable(~lung|smoke, values=c(1,9,1,99), levels=yn)
b.s <- cptable(~bronc|smoke, values=c(6,4,3,7), levels=yn)
e.lt <- cptable(~either|lung:tub,values=c(1,0,1,0,1,0,0,1),levels=yn)
x.e <- cptable(~xray|either, values=c(98,2,5,95), levels=yn)
d.be <- cptable(~dysp|bronc:either, values=c(9,1,7,3,8,2,1,9),
                levels=yn)
plist <- compileCPT(list(a, t.a, s, l.s, b.s, e.lt, x.e, d.be))
plist

# 核对一些nodes的conditional probability
plist$tub
plist$either

# 或者可以这么做
plist$tub %>% as.data.frame.table

# 绘制贝叶斯网络
net1 = grain(plist)
plot(net1)
plot(net1$dag)


# 计算边际概率
querygrain(net1, nodes = c("lung", "bronc"), type = "marginal")

# 计算联合概率
querygrain(net1, nodes=c("lung","bronc"), type="joint")

# conditional probability
querygrain(net1, nodes = c("lung", "bronc"),
           type = "conditional")



# ====================================
# P(lung = yes, bronc = yes)
querygrain(net1, nodes = c("lung", "bronc"), type = "joint")

# p(bronc = yes)
querygrain(net1, nodes = c("bronc"), type = "marginal")

# p(lung = yes | smoke = yes)
querygrain(net1, nodes = c("lung", "smoke"), type = "conditional")

# p(xray = yes | smoke = yes)
querygrain(net1, nodes = c("xray", "smoke"), type = "conditional")

# P(xray = yes | smoke = yes, asia = yes)
querygrain(net1, nodes = c("xray", "smoke", "asia"), type = "conditional")

#P(lung=yes|asia=yes)
querygrain(net1, nodes=c("lung","asia")
           , type="conditional")

##P(bronc=yes|smoke=yes, asia=yes)
querygrain(net1, nodes=c("bronc","smoke","asia")
           , type="conditional")
