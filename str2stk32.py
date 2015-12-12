import binascii
import sys

if len(sys.argv) <= 1:
	print "missing arguments( given \"path string\" )" 
	exit(1)

strlen = len(sys.argv[1])
str = sys.argv[1]
cnt = strlen /4
cnt += 1 if strlen%4!=0 else 0

for	i	in	xrange(0,cnt):
	s = binascii.hexlify(str[(cnt-i-1)*4:(cnt-i)*4][::-1])
	bytes = len(s)/2
	s = "0x"+s

	if bytes == 1 :
		print "mov al,"+s
		print "movzx eax,al"
		print "push eax"
	elif bytes == 2:
		print "mov ax,"+s
		print "movzx eax,ax"
		print "push eax"
	else:
		print "push "+s