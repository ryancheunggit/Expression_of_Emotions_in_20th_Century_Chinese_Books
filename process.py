pos = file('pos.txt')
neg = file('neg.txt')

f = open('posclean.txt','w')
for line in pos:
    if line.split()[1]!='year':
        f.write(line)

f.close()

f = open('negclean.txt','w')
for line in neg:
    if line.split()[1]!='year':
        f.write(line)

f.close()
