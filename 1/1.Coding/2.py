#!/usr/bin/env python

def whatisthis(number):
    whatis = [0] * 3

    if number % 3 == 0:
        whatis[0] = 1

    if number % 5 == 0:
        whatis[1] = 1

    return whatis

for i in range(1, 101):
    num = whatisthis(i)
    if (num[0] == 1) and (num[1] == 0):
        print "foo"
    if (num[0] == 0) and (num[1] == 1):
        print "bar"
    if (num[0] == 1) and (num[1] == 1):
        print "foobar"
    if (num[0] == 0) and (num[1] == 0):
        print i
