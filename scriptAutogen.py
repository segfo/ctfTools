#!/usr/bin/python3
#coding: utf-8
import sys
import os
import libstrings
from operator import attrgetter
from pwn import *

def printUsage(module):
    print("%s <elfFile>"%(module))

argv = sys.argv
argc = len(argv)
elf = None
if argc < 2:
    printUsage(argv[0])
    exit(1)

fileName = argv[1]

try:
	elf = ELF(fileName)
except:
	print("%s file not found."%fileName)
	exit(0)

pwnPyTemplate = """#!/usr/bin/python3
from pwn import *

e = ELF("%s");
r = remote("localhost",11111)
bofPattern = cyclic(2048)
r.send()
r.recv()
# wait recvuntil
r.recvuntil("1337 input:")
# wait lines
line=r.recvlines(2)
#cyclic_find()
#r.recvall()
#r.interactive()
r.close()
"""%(fileName)

gdbServerTemplate = """#!/bin/sh
gdbserver localhost:22222 %s
"""%(fileName)

gdbCmdTemplate = """target remote localhost:22222
si
ni
b __libc_start_main
c
b *($rdi)
c
"""

runGdbTempleate = """
gdb -x ./gdbCmd %s
"""%(fileName)

runGdbSvrTemplate = """#!/bin/sh
socat tcp-l:11111,reuseaddr,fork exec:./__gdbServer
"""

gdbCmd = open("gdbCmd","w")
gdbserver = open("__gdbServer","w")
pwnPy = open("exploit.py","w")
gdbCmd.write(gdbCmdTemplate)
gdbserver.write(gdbServerTemplate)
pwnPy.write(pwnPyTemplate)
gdbCmd.close()
gdbserver.close()
pwnPy.close()

runGdb = open("runGdb.sh","w")
runGdbSvr = open("runGdbServer.sh","w")
runGdb.write(runGdbTempleate)
runGdbSvr.write(runGdbSvrTemplate)
runGdb.close()
runGdbSvr.close()

#chmod
os.chmod("__gdbServer",0o755)
os.chmod("runGdbServer.sh",0o755)
os.chmod("runGdb.sh",0o755)
os.chmod("exploit.py",0o755)

if fileName[0:2] == "./":
    fileName = fileName[2:]
os.chmod(fileName,0o755)

stringsTxt = open("strings.txt","w")
str,maxLen = libstrings.getStrings(elf.file)

# length sort (default : address sort)
str = sorted(str,key=attrgetter('len'))
for s in str:
    tab = " "*(1+int(math.log10(maxLen))-int(math.log10(s.len)))
    stringsTxt.write("%x(%d)%s: %s\n"%(s.addr+elf.load_addr,s.len,tab,s.data))

stringsTxt.close()
