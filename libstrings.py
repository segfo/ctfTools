#!/usr/bin/python3
#coding: utf-8

import string
import math
from pwn import *
from collections import *

stringsData = namedtuple('stringsData','addr len data')

def getStrings(file, min=4):
    result = ""
    f = file
    resultData = []
    cnt = 0
    maxLen = 0
    for c in f.read():
        cnt += 1
        c = chr(c)
        if c in string.printable:
            if c == '\n':
                result += "\\n"
            else:
                result += c
                continue
        if len(result) >= min:
            resultData.append(stringsData(cnt-len(result)-1,len(result),result))
            if maxLen < len(result):
                maxLen = len(result)
        result = ""
    return resultData,maxLen
