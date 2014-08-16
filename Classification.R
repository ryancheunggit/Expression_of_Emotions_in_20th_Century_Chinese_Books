# load data

total <- read.table("summaryout.txt", header = T)
posdf <- read.csv("posdf.csv", stringsAsFactors = F, header = T)
negdf <- read.csv("negdf.csv", stringsAsFactors = F, header = T)
clusters <- read.csv("Clusters.csv", header = T)
df <- as.data.frame(cbind(posdf[,2:595], negdf[,2:702],clusters$Cluster))
row.names(df) <- posdf[,1]
names(df)[1296] <- 'Cluster'
df[,1:1295] <- df[,1:1295]/total[,3]
df$Cluster <- as.factor(df$Cluster)

# remove duplicated columns


names(df)[129]
names(df)[771]
df <- as.data.frame(cbind(df[,1:770],df[,772:1296]))
names(df)[175]
names(df)[831]
df <- as.data.frame(cbind(df[,1:830],df[,832:1295]))
names(df)[184]
names(df)[834]
df <- as.data.frame(cbind(df[,1:833],df[,835:1294]))
names(df)[392]
names(df)[1080]
df <- as.data.frame(cbind(df[,1:1079],df[,1081:1293]))
names(df)[401]
names(df)[1093]
df <- as.data.frame(cbind(df[,1:1092],df[,1094:1292]))
names(df)[441]
names(df)[1115]
df <- as.data.frame(cbind(df[,1:1114],df[,1116:1291]))
names(df)[493]
names(df)[1181]
df <- as.data.frame(cbind(df[,1:1180],df[,1182:1290]))
names(df)[578]
names(df)[1265]
df <- as.data.frame(cbind(df[,1:1264],df[,1266:1289]))
names(df)[581]
names(df)[1274]
df <- as.data.frame(cbind(df[,1:1273],df[,1275:1288]))
write.csv(df, "FreqMatrix.csv")

# Decision Tree Model
# Training 

library(rpart)
library(rpart.plot)
modelrpart <- rpart(Cluster~.,method = "class", data = df[,2:1288])


# Prediction

predrpart <- predict(modelrpart, newdata = df[,2:1287], type = "class")


#  Confusion Matrix

table(predict = predrpart, truth = df$Cluster)


# Model Detail

print(modelrpart)


# Plot the Model

prp(modelrpart)

# lasso model
library(glmnet)

alpha=1.0  # lasso

x <- df[,2:1287]
y <- df[,1288]

# training
f=glmnet(x=as.matrix(x), y=as.matrix(y), alpha=alpha, family="multinomial")

# print summary
summary(f)

# plot
plot(f)
plot(f, xvar="dev") 

# 10 fold cross validation training
cv = cv.glmnet(x=as.matrix(x), y=as.matrix(y), alpha=alpha, family="multinomial")

# see number of feature(word)used for each lambda
cv$nzero
plot(cv)

coefmin <- coef(f, cv$lambda.min)
coefmin[1]
coefmin[2]
coefmin[3]
coefmin[4]
coefmin[5]
coef1se <- coef(f, cv$lambda.1se)
