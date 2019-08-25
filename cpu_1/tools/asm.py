def op_imm(op, rd, rs1, imm):
    op_imm_code = 0b0010011
    if op == 'add':
        func3 = 0b000
    x = imm * (2**20) + rs1 * (2**15) + func3 * \
        (2**12) + rd * (2**7) + op_imm_code
    return x


def op(op, rd, rs1, rs2):
    op_imm_code = 0b0110011
    if op == 'add':
        func3 = 0b000
        func7 = 0b0000000
    if op == 'sub':
        func3 = 0b000
        func7 = 0b0100000
    x = func7 * (2**25) + rs2*(2**20) + rs1 * (2**15) + \
        func3 * (2**12) + rd * (2**7) + op_imm_code

    return x


def main():
    x = op_imm('add', 4, 0, 9)
    print(x)
    print("{:032b}".format(x))
    x = op_imm('add', 0, 0, 0)
    print(x)
    x = op_imm('add', 5, 4, 3)
    print(x)
    x = op_imm('add', 6, 5, 13)
    print(x)
    x = op('add', 7, 6, 5)
    print(x)


if __name__ == '__main__':
    main()
