CC=gnatmake
CFLAGS=-g -D bld -Isrc -gnaty -gnatwa -gnatVa -gnato -gnatE

all: adadepviz

adadepviz:
	$(CC) $(CFLAGS) adadepviz.adb

clean:
	rm -rf bld/* adadepviz
