import asm2ASM as a2A

instbytes = {"HLT":2, "PUSH":2, "PUSHN":6, "PUSHA":9, "POP":2, "MOVPC":2,
             "SETE":2, "SETNE":2, "SETL":2, "SETLE":2,
             "JMPR":2, "JMP":9, "JE":9, "JNZ":9,
             "MOV":3, "MOVRN":6, "MOVRA":3, "MOVRA4":3, "MOVRA1":3,
             "MOVRR1":3, "MOVAR":3, "MOVAR4":3, "MOVAR1":3,
             "ADD":3, "ADDN":6, "SUB":3, "SUBN":6, "MUL":3, "MULN":6,
             "AND":3, "ANDN":6, "CMP":3, "CMPN":6}

insts = {"HLT":"00", "PUSH":"04", "PUSHN":"05", "PUSHA":"06", "POP":"08", "MOVPC":"0C",
         "SETE":"10", "SETNE":"14", "SETL":"18", "SETLE":"1C",
         "JMPR":"20", "JMP":"22", "JE":"26", "JNZ":"2A",
         "MOV":"40", "MOVRN":"41", "MOVRA":"44", "MOVRA4":"48", "MOVRA1":"4C",
         "MOVRR1":"50", "MOVAR":"54", "MOVAR4":"58", "MOVAR1":"5C",
         "ADD":"80", "ADDN":"81", "SUB":"84", "SUBN":"85", "MUL":"88", "MULN":"89",
         "AND":"8C", "ANDN":"8D", "CMP":"90", "CMPN":"91"}

regs = {"RAX":"00", "RDI":"01", "RSI":"02", "RDX":"03", "RCX":"04",
        "RBP":"05", "RSP":"06", "RBX":"07", "R8":"08", "R9":"09"}

def printinst(line, addr):
  address = format(addr, '04X')
  print("mem[16'h" + address + "] = 8'h" + insts[line[0]] + ';', end='')
  print(" //", ' '.join(line))
  return addr + 1

def printaddr(line, addr, label):
  addr = printinst(line, addr)
  if line[1] in label:
    num = format(label[line[1]], '016X')
    for i in range(8):
      address = format(addr, '04X')
      print("mem[16'h" + address + "] = 8'h" + num[14-2*i:16-2*i] + ';')
      addr += 1
    return addr
  else:
    a2A.error(line[0])

def printnum(line, addr):
  addr = printinst(line, addr)
  address = format(addr, '04X')
  if line[1] in regs and line[2].isdigit():      
    print("mem[16'h" + address + "] = 8'h" + regs[line[1]] + ';')
    num = format(int(line[2]), '08X')
  elif line[0] == "PUSHN":
    print("mem[16'h" + address + "] = 8'h00;")
    num = format(int(line[1]), '08X')
  else:
    a2A.error(line[0])
  addr += 1  
  for i in range(4):
    address = format(addr, '04X')
    print("mem[16'h" + address + "] = 8'h" + num[6-2*i:8-2*i] + ';')
    addr += 1
  return addr

def printbytes3(line, addr):
  addr = printinst(line, addr)
  if line[1] in regs and line[2] in regs:
    for i in range(2):
      address = format(addr, '04X')
      print("mem[16'h" + address + "] = 8'h" + regs[line[i+1]] + ';')
      addr += 1
    return addr
  else:
    a2A.error(line[0])

def printbytes2(line, addr):
  addr = printinst(line, addr)
  address = format(addr, '04X')
  if line[0] == "HLT":
    print("mem[16'h" + address + "] = 8'h00;")
    return addr + 1
  elif line[1] in regs:
    print("mem[16'h" + address + "] = 8'h" + regs[line[1]] + ';')
    return addr + 1
  else:
    a2A.error(line[0])

def gen(data, label):
  addr = 0
  for line in data:
    if ':' in line[0]:
      print("                       // " + line[0])
    elif line[0] == ".zero":
      if line[1].isdigit():
        for i in range(int(line[1])):
          address = format(addr, '04X')
          print("mem[16'h" + address + "] = 8'h00;")
          addr += 1
      else:
        a2A.error(line[0])
    elif line[0] == ".byte":
      if line[1].isdigit():
        address = format(addr, '04X')
        num = format(int(line[1]), '02X')
        print("mem[16'h" + address + "] = 8'h" + num + "00;")
        addr += 1
      else:
        a2A.error(line[0])
    elif line[0] in instbytes:
      if instbytes[line[0]] == 9:
        addr = printaddr(line, addr, label)
      elif instbytes[line[0]] == 6:
        addr = printnum(line, addr)
      elif instbytes[line[0]] == 3:
        addr = printbytes3(line, addr)
      elif instbytes[line[0]] == 2:
        addr = printbytes2(line, addr)
      else:
        a2A.error(line[0])
    else:
      a2A.error(line[0])

def getlabeladdr(data):
  label = {}
  addr = 0
  for line in data:
    if ':' in line[0]:
      label.update({line[0].strip(':') : addr})
    elif line[0] == ".zero":
      if line[1].isdigit():
        addr += int(line[1])
      else:
        a2A.error(line[0])
    elif line[0] == ".byte":
      addr += 1
    elif line[0] in instbytes:
      addr += instbytes[line[0]]
    else:
      a2A.error(line[0])

  return label

def codegen(data):
  label = getlabeladdr(data)
  gen(data, label)
  return

def main():
  name = 'TMP.s'
  data = a2A.fileload(name)
  codegen(data)
  return

if __name__ == '__main__':
  main()