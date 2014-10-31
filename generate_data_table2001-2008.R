# 读入详细数据

negdetail <- read.table("negclean2001-2008.txt", header = F, stringsAsFactors = F)
posdetail <- read.table("posclean2001-2008.txt", header = F, stringsAsFactors = F)

# 生成数据框

rowlabel = seq(2001,2008)
posdf <- data.frame(rowlabel)
poslabel = unique(posdetail[,1])
for (i in 1:length(poslabel)){
  subset <- subset(posdetail, posdetail[,1] == poslabel[i])
  newcolumn <- rep(0,length(rowlabel))
  for (j in 1:nrow(subset)){
    newcolumn[subset[j,2]-2000] = subset[j,3]
  }
  posdf <- cbind(posdf,newcolumn)
}
names(posdf) <- c("year",poslabel)


rowlabel = seq(2001,2008)
negdf <- data.frame(rowlabel)
neglabel = unique(negdetail[,1])
for (i in 1:length(neglabel)){
  subset <- subset(negdetail, negdetail[,1] == neglabel[i])
  newcolumn <- rep(0,length(rowlabel))
  for (j in 1:nrow(subset)){
    newcolumn[subset[j,2]-2000] = subset[j,3]
  }
  negdf <- cbind(negdf,newcolumn)
}
names(negdf) <- c("year",neglabel)

# 写出数据

write.csv(negdf, file = "negdf2001-2008.csv", row.names = F)
write.csv(posdf, file = "posdf2001-2008.csv", row.names = F)