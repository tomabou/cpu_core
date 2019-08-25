import itertools
import sys


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
    if len(tks) != 2:
        return [tks]
    if tks[0] == 'nop':
        return int(tks[1]) * [['nop']]


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
    content = map(lambda tks: list(map(rename_register, tks)), content)
    return content


def main(filename):
    data = open(filename, 'r')
    content = data.read()
    res = create(content)
    for line in res:
        print(line)
    data.close()


if __name__ == '__main__':
    args = sys.argv
    if len(args) != 2:
        print("input file name")

    else:
        main(args[1])
