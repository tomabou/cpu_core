import itertools
import sys
from typing import List


def op_imm(op, rd, rs1, imm):
    rd = int(rd[1:])
    rs1 = int(rs1[1:])
    imm = int(imm)
    imm = imm & (2**12 - 1)
    op_imm_code = 0b0010011
    if op == 'addi':
        func3 = 0b000
    x = imm * (2**20) + rs1 * (2**15) + func3 * \
        (2**12) + rd * (2**7) + op_imm_code
    return x


def jalr(op, rd, rs1, imm):
    rd = int(rd[1:])
    rs1 = int(rs1[1:])
    imm = int(imm)
    imm = imm & (2**12 - 1)
    opcode = 0b1100111
    func3 = 0b000
    x = imm * (2**20) + rs1 * (2**15) + func3 * \
        (2**12) + rd * (2**7) + opcode
    return x & (2**32 - 1)


def op(op, rd, rs1, rs2):
    rd = int(rd[1:])
    rs1 = int(rs1[1:])
    rs2 = int(rs2[1:])
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


def jal(op, rd, offset):
    jal_opcode = 0b1101111
    rd = int(rd[1:])
    b30_21 = (2**10 - 1) & (offset >> 1)
    b20 = (1) & (offset >> 11)
    b19_12 = (2**8 - 1) & (offset >> 12)
    b31 = 1 & (offset >> 20)
    x = (b31 << 31) + (b30_21 << 21) + (b20 << 20) + \
        (b19_12 << 12) + (rd << 7) + jal_opcode
    return x


def branch(op, rs1, rs2, offset):
    branch_opcode = 0b1100011
    tmp = {
        'beq': 0,
        'bne': 1,
        'blt': 4,
        'bge': 5,
        'bltu': 6,
        'bgeu': 7,
    }
    func3 = tmp[op]
    rs1 = int(rs1[1:])
    rs2 = int(rs2[1:])

    b11_8 = (2**4-1) & (offset >> 1)
    b30_25 = (2**6 - 1) & (offset >> 5)
    b7 = 1 & (offset >> 11)
    b31 = 1 & (offset >> 12)

    x = (b31 << 31) + (b30_25 << 25) + (rs2 << 20)+(rs1 << 15) + \
        (func3 << 12) + (b11_8 << 8) + (b7 << 7)+branch_opcode
    return x


def load(op, rd, rs1, offset):
    rd = int(rd[1:])
    rs1 = int(rs1[1:])
    offset = int(offset)
    funct3 = 0b010
    opcode = 0b0000011
    x = (offset << 20) + (rs1 << 15) + (funct3 << 12) + (rd << 7) + opcode
    return x


def store(op, src, base, offset):
    base = int(base[1:])
    src = int(src[1:])
    offset = int(offset)
    funct3 = 0b010
    opcode = 0b0100011
    imm11_5 = (offset >> 5) & (2**7-1)
    imm4_0 = offset & (2**5-1)
    x = (imm11_5 << 25) + (src << 20)+(base << 15) + \
        (funct3 << 12)+(imm4_0 << 7) + opcode
    return x


def decode_op(labels, index, tks):
    OP = ['add', 'slt', 'sltu', 'and', 'or', 'xor', 'sll', 'srl', 'sub', 'sra']
    if tks[0] in OP:
        return op(tks[0], tks[1], tks[2], tks[3])
    OP_IMM = ['addi', 'slti', 'sltiu', 'xori', 'ori', 'andi']
    if tks[0] in OP_IMM:
        return op_imm(tks[0], tks[1], tks[2], tks[3])
    if tks[0] == 'jal':
        offset = labels[tks[2]] - 4*index
        return jal(tks[0], tks[1], offset)
    if tks[0] == 'jalr':
        if type(tks[3]) != int:
            offset = labels[tks[3]] - 4*index
        else:
            offset = tks[3]
        return jalr(tks[0], tks[1], tks[2], offset)

    BRANCH = ['beq', 'bne', 'blt', 'bge', 'bltu', 'bgeu']
    if tks[0] in BRANCH:
        offset = labels[tks[3]] - 4*index
        return branch(tks[0], tks[1], tks[2], offset)

    LOAD = ['lw']
    if tks[0] in LOAD:
        return load(tks[0], tks[1], tks[2], tks[3])
    STORE = ['sw']
    if tks[0] in STORE:
        return store(tks[0], tks[1], tks[2], tks[3])

    return -1


def decode_op_func(content, labels):
    new_content = []
    for i, tks in enumerate(content):
        new_content.append(decode_op(labels, i, tks))
    return new_content


def is_not_label(tks):
    return tks[0][-1] != ':'


def label_func(content: List[List[str]]):
    new_content = []
    labels = dict()
    for tks in content:
        if is_not_label(tks):
            new_content.append(tks)
        else:
            labels[tks[0][:-1]] = 4*len(new_content)

    return new_content, labels


def rename_register(tk):

    li = [
        'zero',
        'ra',
        'sp',
        'gp',
        'tp',
        't0',
        't1',
        't2',
        's0',
        's1',
        'a0',
        'a1',
        'a2',
        'a3',
        'a4',
        'a5',
        'a6',
        'a7',
        's2',
        's3',
        's4',
        's5',
        's6',
        's7',
        's8',
        's9',
        's10',
        's11',
        't3',
        't4',
        't5',
        't6',
    ]
    if tk in li:
        return 'x'+str(li.index(tk))
    return tk


def pseudoinst(tks):
    if (tks[0] == 'nop'):
        return ['addi', 'x0', 'x0', 0]
    if (tks[0] == 'j'):
        return ['jal', 'x0', tks[1]]
    if (tks[0] == 'call'):
        return ['jalr', 'x1', 'x0', tks[1]]
    if (tks[0] == 'ret'):
        return ['jalr', 'x0', 'x1', 0]
    return tks


def decode_ls(tks):
    tmp = ['lw', 'sw']
    if not tks[0] in tmp:
        return tks

    print(tks)
    offset, base = tks[2].replace(')', '').split('(')
    return [tks[0], tks[1], base, offset]


def repeate_nop(tks):
    if tks[0] == 'nop' and len(tks) == 2:
        return int(tks[1]) * [['nop']]
    else:
        return [tks]


def tokens(string: str):
    string = string.replace(',', ' ')
    token = string.split()
    return token


def is_effect_line(string):
    for c in string:
        if c == '#':
            return False
        if c == ';':
            return False
        if c != ' ':
            return True
    return False


def create(content):
    content = content.splitlines()
    content = filter(is_effect_line, content)
    content = map(tokens, content)
    content = list(itertools.chain.from_iterable(map(repeate_nop, content)))
    content = map(pseudoinst, content)
    content = map(decode_ls, content)
    content = list(map(lambda tks: list(map(rename_register, tks)), content))
    content, labels = label_func(content)
    print(list(content))
    print(labels)
    content = decode_op_func(content, labels)
    return content


def create_mif(content: List[int], filename):
    print(filename)
    head = [
        "WIDTH=32;",
        "DEPTH=16384;",
        "ADDRESS_RADIX=UNS;",
        "DATA_RADIX=UNS;",
        "CONTENT BEGIN"]
    end = ["END;"]

    body = []
    for i, x in enumerate(content):
        body.append("   {} : {};".format(i, x))
    data = head+body+end
    data = map(lambda x: x+'\n', data)
    with open(filename, 'w') as file:
        file.writelines(data)


def main(filename):
    data = open(filename, 'r')
    content = data.read()
    res = create(content)
    create_mif(res, filename[:-1]+'mif')
    data.close()


if __name__ == '__main__':
    args = sys.argv
    if len(args) != 2:
        print("input file name")

    else:
        main(args[1])
