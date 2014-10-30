# -*- coding:utf-8 -*-

poswords = []
negwords = []

pos = file('cnpositiveemotionwords.txt')
neg = file('cnnegativeemotionwords.txt')

for line in pos:
    poswords.append(line.split()[0])

    
for line in neg:
    negwords.append(line.split()[0])

lines = []


for word in poswords:
    c1 = "select "
    c2 = "\'"+word+"\'"
    c3 = ",year,sum(match_count), sum(volume_count)\n"
    c4 = "from cn1gram\n"
    c5 = "where (year >= 2001 and year <= 2008) and (ngram ="
    c6 = "\'"+word+"\'"
    c7 = " or ngram regexp \'^"+word+"_\')\n"
    c8 = "group by year\n"
    c9 = "order by year desc;\n \n"
    line = c1+c2+c3+c4+c5+c6+c7+c8+c9
    lines.append(line)
    
f = open('querypos2001-2008.txt','w')
f.write("use ngram\n\n")
f.writelines(lines)
f.close()

lines = []


for word in negwords:
    c1 = "select "
    c2 = "\'"+word+"\'"
    c3 = ",year,sum(match_count), sum(volume_count)\n"
    c4 = "from cn1gram\n"
    c5 = "where (year >= 2001 and year <= 2008) and (ngram ="
    c6 = "\'"+word+"\'"
    c7 = " or ngram regexp \'^"+word+"_\')\n"
    c8 = "group by year\n"
    c9 = "order by year desc;\n \n"
    line = c1+c2+c3+c4+c5+c6+c7+c8+c9
    lines.append(line)

f = open('queryneg2001-2008.txt','w')
f.write("use ngram\n\n")
f.writelines(lines)
f.close()

