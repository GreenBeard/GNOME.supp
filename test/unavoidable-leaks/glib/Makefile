SUPP_FILES = get_application_name.supp

CFLAGS = $(shell pkg-config --cflags glib-2.0)
LIBS = $(shell pkg-config --libs glib-2.0)

.PHONY: clean test
.PRECIOUS: .%.bin

clean:
	$(RM) -r .*.bin .*.dSYM $(SUPP_FILES)

test: ../../../src/glib/glib-Miscellaneous-Utility-Functions.supp $(SUPP_FILES)
	test `valgrind-suppressions-util count get_application_name.supp` -gt 0
	valgrind-suppressions-util covers ../../../src/glib/glib-Miscellaneous-Utility-Functions.supp get_application_name.supp

.%.bin: %.c
	$(CC) -o $@ $(CFLAGS) $+ $(LIBS)
%.supp: .%.bin
	valgrind --leak-check=full --show-leak-kinds=all --gen-suppressions=all --suppressions=../../../src/system.supp ./$< 2>&1 >/dev/null | ../../../trim-valgrind-log.awk >$@
