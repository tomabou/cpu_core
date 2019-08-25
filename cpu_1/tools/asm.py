import itertools
import sys
from typing import List


def op_imm(op, rd, rs1, imm):
    rd = int(rd[1:])
    rs1 = int(rs1[1:])
    imm = int(imm)
    op_imm_code = 0b0010011
    if op == 'addi':
        func3 = 0b000
    x = imm * (2**20) + rs1 * (2**15) + func3 * \
        (2**12) + rd * (2**7) + op_imm_code
    return x


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
    return tks


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
