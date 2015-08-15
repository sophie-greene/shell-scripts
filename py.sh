 #!/bin/bash
echo "1 is $1";
export var="$1"

function jdata() {
PYTHON_ARG="$1" python - <<END

import sys

MSGS = ("---  11 secret messages  ---")

def strxor(a, b):     # xor two strings of different lengths
	if len(a) > len(b):
		return "".join([chr(ord(x) ^ ord(y)) for (x, y) in zip(a[:len(b)], b)])
	else:
		return "".join([chr(ord(x) ^ ord(y)) for (x, y) in zip(a, b[:len(a)])])

def random(size=16):
	l=open("/dev/urandom").read(size)
	print "some %s."%l
	return open("/dev/urandom").read(size)

def encrypt(key, msg):
	c = strxor(key, msg)
	print "msg %s."%msg
	print "c.encode %s."%c.encode('hex')
	return c

def main():
	key = random(1024)
	ciphertexts = [encrypt(key, msg) for msg in MSGS]
	echo "key %s." % key
END
}


jdata "$1";




