CC=g++
#CFLAGS= -O3 -pg -Wall
MYBINDIR="./"
UNAME= $(shell uname)
ifeq ($(UNAME), Linux)
	CFLAGS=-O3
endif
ifeq ($(UNAME), Darwin)
	CFLAGS=-fast
endif
OFILE := bm.o utility.o
OUTPUT := sbm testingBP
all: ${OUTPUT} testingBP ${OFILE}

${OUTPUT}: ${OFILE}
	${CC} -o ${MYBINDIR}/$@ ${CFLAGS} $@.cpp ${OFILE}
%.o : %.cpp
	${CC} ${CFLAGS} -c $< -o $@

clean:
	rm -f *.o sbm tags
