#TARGETS=a q2 compile_ta
TARGETS=demo
CC_C=$(CROSS_TOOL)gcc
#CFLAGS=-Wall -g -std=c99 
CFLAGS=-g -pthread
all: clean $(TARGETS)
$(TARGETS):
	$(CC_C) $(CFLAGS) $@.c -o $@
clean:
	rm -f $(TARGETS)
#chmod u+x deploy.sh