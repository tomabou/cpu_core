
def show_bin(n):
    print("{:08b}".format(n & (2**8-1)))
    n = n >> 8
    print("{:08b}".format(n & (2**8-1)))
    n = n >> 8
    print("{:08b}".format(n & (2**8-1)))
    n = n >> 8
    print("{:08b}".format(n & (2**8-1)))
