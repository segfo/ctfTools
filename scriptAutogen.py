#!/usr/bin/python
#coding: utf-8
import sys
import os
import strings
from pwn import *

def printUsage(module):
    print   "%s <elfFile>"%(module)

argv = sys.argv
argc = len(argv)
elf = None
if argc < 2:
    printUsage(argv[0])
    exit(1)
try:
    elf = ELF(argv[1])
except:
    print "\"%s\"file not found."%(argv[1])
    exit(1)

fileName = argv[1]

pwnPyTemplate = """
#!/usr/bin/python
from pwn import *

e = ELF("%s")
pltRead = p32(e.plt["read"])

r = remote("localhost",11111)
"""%(fileName)

gdbServerTemplate = """
#!/bin/sh
gdbserver localhost:22222 %s
"""%(fileName)

gdbCmdTemplate = """
target remote localhost:22222
b *0x%x
c
"""%(elf.start)

runGdbTempleate = """
gdb -x ./gdbCmd %s
"""%(fileName)

runGdbSvrTemplate = """
socat tcp-l:11111,reuseaddr,fork exec:./gdbserver
"""

gdbCmd = open("gdbCmd","w")
gdbserver = open("gdbServer","w")
pwnPy = open("exploit.py","w")
gdbCmd.write(gdbCmdTemplate)
gdbserver.write(gdbServerTemplate)
pwnPy.write(pwnPyTemplate)
gdbCmd.close()
gdbserver.close()
pwnPy.close()

runGdb = open("gdbRun","w")
runGdbSvr = open("gdbServerRun","w")
runGdb.write(runGdbTempleate)
runGdbSvr.write(gdbServerTemplate)
runGdb.close()
runGdbSvr.close()

#chmod
os.chmod("gdbServer",0755)
os.chmod("gdbServerRun",0755)
os.chmod("gdbRun",0755)
os.chmod("exploit.py",0755)

if fileName[0:2] == "./":
    fileName = fileName[2:]
os.chmod(fileName,0755)

stringsTxt = open("strings.txt","w")
str,maxLen = strings.getStrings(elf.file)
for s in str:
    tab = " "*(1+int(math.log10(maxLen))-int(math.log10(s.len)))
    stringsTxt.write("%x(%d)%s: %s\n"%(s.addr+elf.load_addr,s.len,tab,s.data))

stringsTxt.close()
