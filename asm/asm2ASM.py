import logging as lg

regs1 = {"rax":"RAX", "rdi":"RDI", "rsi":"RSI", "rdx":"RDX", "rcx":"RCX", 
         "rbp":"RBP", "rsp":"RSP", "rbx":"RBX", "r8":"R8", "r9":"R9", }
regs4 = {"eax":"RAX", "edi":"RDI", "esi":"RSI", "edx":"RDX", "ecx":"RCX",
         "ebp":"RBP", "esp":"RSP", "ebx":"RBX", "r8d":"R8", "r9d":"R9",}
regs8 = {"al":"RAX", "dil":"RDI", "sil":"RSI", "dl":"RDX","cl":"RCX",
         "bpl":"RBP", "spl":"RSP", "bl":"RBX", "r8b":"R8", "r9b":"R9"}

def error(word):
  lg.error(word)
  exit()

def fileload(name):
  data = []
  with open(name, 'r', encoding='utf-8') as f:
    tmp = f.read().splitlines()
    for line in tmp:
      line = line.replace(',', '').split()
      data.append(line)
  return data

def trans(line):
  if ':' in line[0]:
    print(line[0])
    if line[0] == ".Lreturn.main:":
      print("\tHLT")
    return

  if line[0] == "push":
    print("\tSUBN RSP 8")
    if line[1] in regs1:
      print("\tPUSH", regs1[line[1]])
    elif line[1] == "offset":
      print("\tPUSHA", line[2])
    elif line[1].isdigit():
      print("\tPUSHN", line[1])
    else:
      error(line[0])
  elif line[0] == "pop":
    if line[1] in regs1:
      print("\tPOP", regs1[line[1]])
      print("\tADDN RSP 8")
    else:
      error(line[0])
  elif line[0] == "movzb":
    if line[1] in regs1 and line[2] in regs8:
      print("\tMOVRR1", regs1[line[1]], regs8[line[2]])
    else:
      error(line[0])
  elif line[0] == "movsxd":
    reg = line[4].strip('[').strip(']')
    if line[1] in regs1 and reg in regs1:
      print("\tMOVRA4", regs1[line[1]], regs1[reg])
    else:
      error(line[0])
  elif line[0] == "movsx":
    reg = line[4].strip('[').strip(']')
    if line[1] in regs1 and reg in regs1:
      print("\tMOVRA1", regs1[line[1]], regs1[reg])
    else:
      error(line[1])
  elif line[0] == "mov":
    if line[1] in regs1:
      if line[2] in regs1:
        print("\tMOV", regs1[line[1]], regs1[line[2]])
      elif '[' in line[2] and ']' in line[2]:
        reg = line[2].strip('[').strip(']')
        print("\tMOVRA", regs1[line[1]], regs1[reg])
      elif line[2].isdigit():
        print("\tMOVRN", regs1[line[1]], line[2])
      else:
        error(line[0])
    elif '[' in line[1] and ']' in line[1]:
      reg = line[1].strip('[').strip(']')
      if reg in regs1 and line[2] in regs1:
        print("\tMOVAR", regs1[reg], regs1[line[2]])
      elif reg in regs1 and line[2] in regs4:
        print("\tMOVAR4", regs1[reg], regs4[line[2]])
      elif reg in regs1 and line[2] in regs8:
        print("\tMOVAR1", regs1[reg], regs8[line[2]])
      elif '-' in reg:
        words = reg.split('-')
        if words[0] in regs1 and words[1].isdigit():          
          print("\tMOV RBX", regs1[words[0]])
          print("\tSUBN RBX", words[1])
          if line[2] in regs1:
            print("\tMOVAR RBX", regs1[line[2]])
          elif line[2] in regs4:
            print("\tMOVAR4 RBX", regs4[line[2]])
          elif line[2] in regs8:
            print("\tMOVAR4 RBX", regs8[line[2]])
          else:
            error(line[0])
        else:
          error(line[0])
      else:
        error(line[0])
    else:
      error(line[0])
  elif line[0] == "add":
    if line[1] in regs1 and line[2] in regs1:
      print("\tADD", regs1[line[1]], regs1[line[2]])
    elif  line[1] in regs1 and line[2].isdigit():
      print("\tADDN", regs1[line[1]], line[2])
    else:
      error(line[0])
  elif line[0] == "sub":
    if line[1] in regs1 and line[2] in regs1:
      print("\tSUB", regs1[line[1]], regs1[line[2]])
    elif  line[1] in regs1 and line[2].isdigit():
      print("\tSUBN", regs1[line[1]], line[2])
    else:
      error(line[0])
  elif line[0] == "imul":
    if line[1] in regs1 and line[2] in regs1:
      print("\tMUL", regs1[line[1]], regs1[line[2]])
    elif  line[1] in regs1 and line[2].isdigit():
      print("\tMULN", regs1[line[1]], line[2])
    else:
      error(line[0])
  elif line[0] == "and":
    if line[1] in regs1 and line[2] in regs1:
      print("\tAND", regs1[line[1]], regs1[line[2]])
    elif  line[1] in regs1 and line[2].isdigit():
      print("\tANDN", regs1[line[1]], line[2])
    else:
      error(line[0])
  elif line[0] == "cmp":
    if line[1] in regs1 and line[2] in regs1:
      print("\tCMP", regs1[line[1]], regs1[line[2]])
    elif  line[1] in regs1 and line[2].isdigit():
      print("\tCMPN", regs1[line[1]], line[2])
    else:
      error(line[0])
  elif line[0] == "sete":
    if line[1] in regs8:
      print("\tSETE", regs8[line[1]])
    else:
      error(line[0])
  elif line[0] == "setne":
    if line[1] in regs8:
      print("\tSETNE", regs8[line[1]])
    else:
      error(line[0])
  elif line[0] == "setl":
    if line[1] in regs8:
      print("\tSETL", regs8[line[1]])
    else:
      error(line[0])
  elif line[0] == "setle":
    if line[1] in regs8:
      print("\tSETLE", regs8[line[1]])
    else:
      error(line[0])
  elif line[0] == "jmp":
    print("\tJMP", line[1])
  elif line[0] == "je":
    print("\tJE", line[1])
  elif line[0] == "jnz":
    print("\tJNZ", line[1])
  elif line[0] == "lea":
    if '[' in line[2] and ']' in line[2]:
      reg = line[2].strip('[').strip(']')
      if '-' in reg and line[1] in regs1:
        words = reg.split('-')
        if words[0] in regs1 and words[1].isdigit():
          print("\tMOV", regs1[line[1]], regs1[words[0]])
          print("\tSUBN", regs1[line[1]], words[1])
        else:
          error(line[0])
      else:
        error(line[0])
    else:
      error(line[0])
  elif line[0] == "call":
    print("\tMOVPC RBX")
    print("\tADDN RBX 23")
    print("\tSUBN RSP 8")
    print("\tPUSH RBX")
    print("\tJMP", line[1])
  elif line[0] == "ret":
    print("\tPOP RBX")
    print("\tADDN RSP 8")
    print("\tJMPR RBX")
  elif line[0] == ".intel_syntax" \
      or line[0] == ".data" \
      or line[0] == ".text" \
      or line[0] == ".global":
    return
  elif '.' in line[0]:
    print('\t', end='')
    print(line[0], line[1])
  else:
    error(line[0])

def translate(data):
  print("\tJMP main")
  for line in data:
    trans(line)
  return

def main():
  name = '../mcc/tmp.s'
  data = fileload(name)
  translate(data)
  return

if __name__ == '__main__':
  main()