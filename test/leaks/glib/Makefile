SUPP_FILES = \
hash_table_0.supp \
hash_table_1.supp \
hash_table_2.supp \
hash_table_3.supp \
listenv.supp

PHONY_TEST_TARGETS = $(patsubst %.supp,test_%,$(SUPP_FILES))

CFLAGS = $(shell pkg-config --cflags glib-2.0)
LIBS = $(shell pkg-config --libs glib-2.0)

.PHONY: clean test $(PHONY_TEST_TARGETS)
.PRECIOUS: .%.bin

clean:
	$(RM) -r .*.bin .*.dSYM $(SUPP_FILES)

test: $(PHONY_TEST_TARGETS)

$(PHONY_TEST_TARGETS): $(SUPP_FILES)
	test `valgrind-suppressions-util count $(patsubst test_%,%.supp,$@)` -gt 0
	! valgrind-suppressions-util covers ../../../build/glib.supp $(patsubst test_%,%.supp,$@)
	valgrind-suppressions-util covers $(patsubst test_%,%-expected.supp,$@) $(patsubst test_%,%.supp,$@)

.%.bin: %.c
	$(CC) -g -o $@ $(CFLAGS) $+ $(LIBS)
%.supp: .%.bin
	valgrind --num-callers=100 --leak-check=full --show-leak-kinds=all --gen-suppressions=all --suppressions=../../../src/system.supp ./$< 2>&1 >/dev/null | ../../../trim-valgrind-log.awk >$@
