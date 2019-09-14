data = open("tmp", 'r')
content = data.readlines()

for x in content:
    print('{:08x}'.format(int(x)))
