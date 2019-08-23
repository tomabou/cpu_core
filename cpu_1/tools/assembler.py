

def imm_op(op, rd, rs1, imm):
    op_imm = 0b0010011
    if op == 'add':
        func3 = 0b000
    x = imm * (2**20) + rs1 * (2**15) + func3 * (2**12) + rd * (2**7) + op_imm
    return x


def main():
    x = imm_op('add', 4, 0, 9)
    print(x)
    print("{:032b}".format(x))
    x = imm_op('add', 0, 0, 0)
    print(x)
    x = imm_op('add', 5, 4, 3)
    print(x)
    x = imm_op('add', 6, 5, 13)
    print(x)


if __name__ == '__main__':
    main()
