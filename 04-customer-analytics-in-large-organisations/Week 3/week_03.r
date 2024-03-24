customers <- data.frame(id=c(1, 2, 3, 4), 
                        gender=c('M', 'M', 'M', 'F'), 
                        mood=c('happy', 'sad', 'happy', 'sad'))

customers

library(data.table)
library(mltools)
customers <- one_hot(as.data.table(customers))

customers


risk <- read.csv("risk.csv")
dim(risk)
head(risk)
colMeans(risk)


risk.dist <- dist(risk, method = "manhattan")
risk.hc1 <- hclust(risk.dist, method = "complete")
risk.hc1

c20 <- cutree(risk.hc1, h = 20)
table(c20)
c6 <- cutree(risk.hc1, k = 6)
table(c6)

c20.means <- aggregate(risk, list(Cluster = c20), mean)
round(c20.means[, -1], 1)

c6 <- cutree(risk.hc1, k = 6)
c6.means <- aggregate(risk, list(Cluster = c6), mean)
round(c6.means[, -1], 1)


library("flexclust")


barchart(risk.hc1, risk, k = 2)
barchart(risk.hc1, risk, k = 6)


library(dbscan)
library(readr)
library("factoextra")
risk <- read_csv("risk.csv")
res.db <- dbscan(risk, eps= 1.5, minPts = 5)
res.db
fviz_cluster(res.db, risk, geom = "point")



library(EMCluster)

emobj <- simple.init(risk, nclass = 6)
risk.em <- emcluster(risk, emobj, assign.class = TRUE)
par(mfrow = c(1, 1))
plotem(risk.em, risk)
summary(risk.em)


emobj <- simple.init(risk, nclass = 6)
risk.em <- emcluster(risk, emobj, assign.class = TRUE)
par(mfrow = c(1, 1))
plotem(risk.em, risk)
summary(risk.em)



library(cluster) 
clusplot(risk, risk.em$class, color=TRUE, shade=TRUE, labels=2, lines=0)
em.means <- aggregate(risk, list(Cluster = risk.em$class), mean)
round(em.means[, -1], 1)
