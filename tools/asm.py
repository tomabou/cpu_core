import itertools
import sys
from typing import List


def op_imm(op, rd, rs1, imm):
    rd = int(rd[1:])
    rs1 = int(rs1[1:])
    imm = int(imm)
    imm = imm & (2**12 - 1)
    op_imm_code = 0b0010011
    func3_set = {
        'addi': 0,
        'slli': 1,
        'slti': 2,
        'sltiu': 3,
        'xori': 4,
        'srli': 5,
        'srai': 5,
        'ori': 6,
        'andi': 7
    }
    func3 = func3_set[op]

    if op == 'srai':
        imm = imm + 0b0100000_00000

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

def opfp(op, rd, rs1, rs2 = 0):
    rd = int(rd[1:])
    rs1 = int(rs1[1:])
    if rs2 == 'rtz':
        rs2 = 0
    elif type(rs2) != int:
        rs2 = int(rs2[1:])
    opcode = 0b1010011

    func7_set = {
        'fcvt.w.s':  0b1100000,
        'fcvt.wu.s': 0b1100000,
        'fcvt.s.w':  0b1101000,
        'fcvt.s.wu': 0b1101000,
        'fmv.w.x' :  0b1111000,
        'fmv.x.w' :  0b1110000,
        'fadd.s' :   0b0000000,
        'fsub.s' :   0b0000100,
        'fmul.s' :   0b0001000,
        'feq.s'  :   0b1010000,
        'flt.s'  :   0b1010000,
        'fle.s'  :   0b1010000,
    }

    if op in ['fcvt.wu.s','fcvt.s.wu']:
        rs2 = 1
        
    if op in ['feq.s']:
        func3 = 2
    elif op in ['flt.s']:
        func3 = 1
    else:
        func3 = 0

    func7 = func7_set[op]
    x = func7 * (2**25) + rs2*(2**20) + rs1 * (2**15) + \
        func3 * (2**12) + rd * (2**7) + opcode

    return x

def op(op, rd, rs1, rs2):
    rd = int(rd[1:])
    rs1 = int(rs1[1:])
    rs2 = int(rs2[1:])
    op_imm_code = 0b0110011
    func3_set = {
        'add': 0,
        'sub': 0,
        'sll': 1,
        'slt': 2,
        'sltu': 3,
        'xor': 4,
        'srl': 5,
        'sra': 5,
        'or': 6,
        'and': 7
    }
    func3 = func3_set[op]
    if op == 'sub' or op == 'sra':
        func7 = 0b0100000
    else:
        func7 = 0
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
    offset = offset & (2**12 -1)

    funct3_dic = {
        'lb'  : 0b000,
        'lh'  : 0b001,
        'lw'  : 0b010,
        'lbu' : 0b100,
        'lhu' : 0b101,
        'flw' : 0b010,
    }
    funct3 = funct3_dic[op]

    tmp = ['lb','lh','lw','lbu','lhu']
    if op in tmp:
        opcode = 0b0000011
    if op == 'flw':
        opcode = 0b0000111
    x = (offset << 20) + (rs1 << 15) + (funct3 << 12) + (rd << 7) + opcode
    return x


def store(op, src, base, offset):
    base = int(base[1:])
    src = int(src[1:])
    offset = int(offset)
    funct3 = 0b010
    if op == 'sw':
        opcode = 0b0100011
    if op == 'fsw':
        opcode = 0b0100111
    imm11_5 = (offset >> 5) & (2**7-1)
    imm4_0 = offset & (2**5-1)
    x = (imm11_5 << 25) + (src << 20)+(base << 15) + \
        (funct3 << 12)+(imm4_0 << 7) + opcode
    return x


def utype(op, rd, offset):
    rd = int(rd[1:])
    if op == 'auipc':
        opcode = 0b0010111
    elif op == 'lui':
        opcode = 0b0110111
    return offset + (rd << 7) + opcode

def sep_small_big(n):
    small = (2**12-1) & n
    if (small >> 11 == 1):
        small = small + ((2**20-1) << 12)
    big = (2**32 - 1) & (n - small)
    return (small,big)

def decode_op(labels, index, tks):
    OP = ['add', 'sub', 'sll', 'slt', 'sltu', 'xor', 'srl', 'sra', 'or', 'and']
    if tks[0] in OP:
        return op(tks[0], tks[1], tks[2], tks[3])
    OP_IMM = ['addi', 'slti', 'sltiu', 'xori',
              'ori', 'andi', 'slli', 'srli', 'srai']
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
    if tks[0] == 'jalr_call':
        assert(type(tks[3]) != int)
        offset = labels[tks[3]] - 4*(index-1)
        offset = (2**12-1) & offset
        return jalr(tks[0], tks[1], tks[2], offset)

    if tks[0] == 'auipc':
        if type(tks[2]) != int:
            offset = labels[tks[2]] - 4*index
            small_offset = (2**12-1) & offset
            if (small_offset >> 11 == 1):
                small_offset = small_offset + ((2**20-1) << 12)
            offset = (2**32 - 1) & (offset - small_offset)
        else:
            offset = tks[3]
        return utype(tks[0], tks[1], offset)

    if tks[0] == 'lui':
        offset = int(tks[2]) << 12
        return utype(tks[0], tks[1], offset)

    BRANCH = ['beq', 'bne', 'blt', 'bge', 'bltu', 'bgeu']
    if tks[0] in BRANCH:
        offset = labels[tks[3]] - 4*index
        return branch(tks[0], tks[1], tks[2], offset)

    LOAD = ['lw', 'flw','lb','lh','lw','lbu','lhu']
    if tks[0] in LOAD:
        return load(tks[0], tks[1], tks[2], tks[3])
    STORE = ['sw', 'fsw']
    if tks[0] in STORE:
        return store(tks[0], tks[1], tks[2], tks[3])

    OP_FP = [
        'fmv.x.w',
        'fmv.w.x',
        'fcvt.w.s',
        'fcvt.wu.s',
        'fcvt.s.w',
        'fcvt.s.wu',
        ]
    if tks[0] in OP_FP:
        return opfp(tks[0],tks[1],tks[2])
    OP_FP3 = [
        'fadd.s',
        'fsub.s',
        'fmul.s',
        'feq.s',
        'flt.s',
        'fle.s',
    ]
    if tks[0] in OP_FP3:
        return opfp(tks[0],tks[1],tks[2],tks[3])

    if tks[0] == '.str':
        return string_constant(tks[1])
    return -1

def string_constant(s):
    assert (len(s)==4)
    ans = 0
    for i in range(4):
        ans += ord(s[i]) << (i*8)
    return ans


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
    fli = [
        'ft0','ft1','ft2','ft3','ft4','ft5','ft6','ft7',
        'fs0','fs1',
        'fa0','fa1',
        'fa2','fa3','fa4','fa5','fa6','fa7',
        'fs2','fs3','fs4','fs5','fs6','fs7','fs8','fs9','fs10','fs11',
        'ft8','ft9','ft10','ft11',
    ]
    if tk in fli:
        return 'f'+str(fli.index(tk))
    return tk




def pseudoinst(tks):
    if (tks[0] == 'nop'):
        return ['addi', 'x0', 'x0', 0]
    if (tks[0] == 'j'):
        return ['jal', 'x0', tks[1]]
    if (tks[0] == 'ret'):
        return ['jalr', 'x0', 'x1', 0]
    if (tks[0] == 'jalr' and len(tks) == 2):
        return ['jalr', 'x1', tks[1], 0]
    if (tks[0] == 'li'):
        im = int(tks[2])
        assert(-2048<im & im < 2047)
        return ['addi', tks[1],'zero',tks[2]]
    if (tks[0] == 'mv'):
        return ['addi', tks[1],tks[2], 0]

    return tks


def decode_call(tks):
    if (tks[0] == 'call'):
        # return [['jal', 'x1', 'x0', tks[1]]]
        return [
            ['auipc', 'x6', tks[1]],
            ['jalr_call', 'x1', 'x6', tks[1]]
        ]
    return [tks]

def decode_string(tks):
    if (tks[0] == '.string'):
        res = []
        s = tks[1]
        l = len(s)
        if l%4 > 0:
            for i in range(4 - l%4):
                s = s + '#'
        for i in range(len(s)//4):
            res.append(['.str',s[i*4:i*4+4]])
        return res
    return [tks]


def decode_ls(tks):
    tmp = ['lw', 'sw', 'flw', 'fsw','lb','lh','lbu','lhu']
    if not tks[0] in tmp:
        return tks

    offset, base = tks[2].replace(')', '').split('(')
    return [tks[0], tks[1], base, offset]


def repeate_nop(tks):
    if tks[0] == 'nop' and len(tks) == 2:
        return int(tks[1]) * [['nop']]
    else:
        return [tks]


def tokens(string: str):
    x = string    
    string = string.replace(',', ' ')
    token = string.split()
    if token[0] == '.string':
        res = ""
        count = 0
        for c in x:
            if c == '"':
                count += 1
            if count == 1:
                res = res + c
        return ['.string',res[1:]]
    return token


def commentout(string: str):
    x = ''
    for c in string:
        if c == '#' or c == ';':
            return x
        else:
            x = x + c
    return x


def is_effect_line(string):
    for c in string:
        if c == '#':
            return False
        if c == ';':
            return False
        if c != ' ':
            return True
    return False

def is_not_information(tks):
    tmp = [
	    ".file",
	    ".option",
	    ".text",
	    ".align",
	    ".globl",
	    ".type",
        ".size",
        ".section",
        ".ident",
    ]
    return not (tks[0] in tmp)

def add_jump(content):
    return [['call','main']] + list(content)

def decode_lo_hi(content,label,program_location):
    new_content=[]
    for tks in content:
        new_tks = []
        for tkn in tks:
            if type(tkn) != str:
                new_tks.append(tkn)
                continue
            if tkn[0:4] == '%hi(':
                flag = tkn[4:-1]
                offset = label[flag] + program_location
                lo,hi = sep_small_big(offset)
                hi = hi >> 12
                new_tks.append(hi)
            elif tkn[0:4] == '%lo(':
                flag = tkn[4:-1]
                offset = label[flag] + program_location
                lo,hi = sep_small_big(offset)
                new_tks.append(lo)
            else:
                new_tks.append(tkn)
        
        new_content.append(new_tks)
    return new_content

def create(content,program_location):
    content = content.splitlines()
    content = filter(is_effect_line, content)
    content = map(commentout, content)
    content = map(tokens, content)
    content = add_jump(content)
    content = list(itertools.chain.from_iterable(map(repeate_nop, content)))
    content = list(itertools.chain.from_iterable(map(decode_call, content)))
    content = list(itertools.chain.from_iterable(map(decode_string, content)))
    content = filter(is_not_information, content)
    content = map(pseudoinst, content)
    content = map(decode_ls, content)
    content = list(map(lambda tks: list(map(rename_register, tks)), content))
    content, labels = label_func(content)
    content = decode_lo_hi(content,labels,program_location)
    for tks in list(content):
        print(tks)
    print(labels)
    content = decode_op_func(content, labels)
    return content


def create_mif(content: List[int], filename):
    print(filename)
    head = [
        "WIDTH=32;",
        "DEPTH=32768;",
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


def create_bin(content: List[int], filename):
    tmp = []
    for i, x in enumerate(content):
        if i > 0:
            tmp.append(1)
        for _ in range(4):
            tmp.append(x & (2**8-1))
            x = x >> 8
    tmp.append(2)
    array = bytearray(tmp)
    with open(filename, 'wb') as file:
        file.write(array)

def location(mode):
    if mode=='bare':
        return 0
    if mode=='loader':
        return 4096
    else:
        print("set mode")
        exit(1)

def main(filename,mode):
    data = open(filename, 'r')
    content = data.read()
    program_location = location(mode)
    res = create(content,program_location)
    create_mif(res, filename[:-1]+'mif')
    create_bin(res, filename[:-1]+'bin')
    data.close()


if __name__ == '__main__':
    args = sys.argv
    if len(args) != 3:
        print("input file name")

    else:
        main(args[1],args[2])
