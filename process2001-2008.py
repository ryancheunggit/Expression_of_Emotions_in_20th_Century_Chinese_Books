pos = file('pos2001-2008.txt')
neg = file('neg2001-2008.txt')

f = open('posclean2001-2008.txt','w')
for line in pos:
    if line.split()[1]!='year':
        f.write(line)

f.close()

f = open('negclean2001-2008.txt','w')
for line in neg:
    if line.split()[1]!='year':
        f.write(line)

f.close()
