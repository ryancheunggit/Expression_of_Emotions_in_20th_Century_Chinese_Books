# Expression of Emotions in 20th Century Chinese Books


## 1 下载google ngram数据集中Chinese 1gram部分，并解压   
下载地址：https://storage.googleapis.com/books/ngrams/books/datasetsv2.html       

## 2 安装MySQL Community Server 5.6.19    
下载地址： http://dev.mysql.com/downloads/      

## 3 下载知网HowNet中文情感词表    
下载地址：http://www.keenage.com/            
正面情感词表：cnpositiveemotionwords.txt              
负面情感词表：cnnegitiveemotionwords.txt      
对词表几个特殊情况略有修改：   
正面情感词表中：                   
“向...倾斜”改为“倾斜”
“给...留面子”改为“给面子”
负面情感词表中：         
“给 ... 当头棒喝”改为“当头棒喝”          
“给 ... 一点颜色看看”改为“给点颜色”           
“向 ... 问罪”改为“问罪”             

## 3 将1gram数据导入数据库:    

### 3.1 新建并进入ngram数据库    
cmd> mysql -u root -p    
sql shell> create database ngram;      
sql shell> use ngram     

### 3.2 创建表cn1gram     
sql shell> create table cn1gram    
        -> ( ngram text default null,              
        ->   year int(11) default null,              
        ->   match_count int(11) default null,             
        ->   volume_count int(11) default null)                
        -> engine = innodb;            
sql shell> \q           

### 3.3 SQL批量导入数据    
SQL批处理文件：loaddata.txt         
cmd> mysql -u root -p < "path/loaddata.txt"    

## 4 SQL检索：计算一些用于正则化处理的数据    
各年总1gram数量           
cmd> mysql -u root -p < "path/summary.txt" > "path/summaryout.txt"             
各年“了”和“的”出现的频次             
cmd> mysql -u root -p < "path/normal1query.txt" > "path/normal1.txt"             
cmd> mysql -u root -p < "path/normal2query.txt" > "path/normal2.txt"   

## 5 检索各年正面和负面情感词语出现的频次

### 5.1 用Python生成SQL检索    
Python代码：querygen.py             
生成的SQL批处理文件：querypos.txt和queryneg.txt

### 5.2 SQL检索：统计每年各情感词出现的频次    
cmd> mysql -u root -p < "path/querypos.txt" > "path/pos.txt"   
cmd> mysql -u root -p < "path/queryneg.txt" > "path/neg.txt"   

### 5.3 用Python稍微处理下5.2输出文件的格式     
Python代码：process.py                  
处理后文件：posclean.txt和negclean.txt

## 6 将情感词频次数据写入数据库

### 6.1 创建表sentiment_neg和sentiment_pos
cmd> mysql -u root -p ngram                       
sql shell> create table sentiment_neg                    
        -> ( ngram text default = null,                   
	->   year int(11) default = null,                   
	->   match_count int(20) default = null,                   
	->   volume_count int(20) default = null)                  
	-> engine = innodb;                  
sql shell> \q                     

### 6.2 SQL批量导入数据
cmd> mysql -u root -p < "path/loadsentiment.txt"

## 7 计算每年正面、负面情感词分别的总频次
cmd> mysql -u root -p < "path/negsum.txt" > "path/negsentiment.txt"                   
cmd> mysql -u root -p < "path/possum.txt" > "path/possentiment.txt"

## 8 生成词频次矩阵
generate_data_frame.R          
生成csv文件：posdf.csv, negdf.csv     

## 9 R中绘图、分析
analysis.Rmd


