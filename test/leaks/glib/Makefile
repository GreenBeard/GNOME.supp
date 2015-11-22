SUPP_FILES = hash_table_0.supp hash_table_1.supp hash_table_2.supp hash_table_3.supp

CFLAGS = $(shell pkg-config --cflags glib-2.0)
LIBS = $(shell pkg-config --libs glib-2.0)

.PHONY: clean test
.PRECIOUS: .%.bin

clean:
	$(RM) -r .*.bin .*.dSYM $(SUPP_FILES)

test: ../../../src/glib/glib-Hash-Tables.supp $(SUPP_FILES)
	test `valgrind-suppressions-util count hash_table_0.supp` -gt 0
	! valgrind-suppressions-util covers ../../../src/glib/glib-Hash-Tables.supp hash_table_0.supp
	valgrind-suppressions-util covers hash_table_0-expected.supp hash_table_0.supp

	test `valgrind-suppressions-util count hash_table_1.supp` -gt 0
	! valgrind-suppressions-util covers ../../../src/glib/glib-Hash-Tables.supp hash_table_1.supp
	valgrind-suppressions-util covers hash_table_1-expected.supp hash_table_1.supp

	test `valgrind-suppressions-util count hash_table_2.supp` -gt 0
	! valgrind-suppressions-util covers ../../../src/glib/glib-Hash-Tables.supp hash_table_2.supp
	valgrind-suppressions-util covers hash_table_2-expected.supp hash_table_2.supp

	test `valgrind-suppressions-util count hash_table_3.supp` -gt 0
	! valgrind-suppressions-util covers ../../../src/glib/glib-Hash-Tables.supp hash_table_3.supp
	valgrind-suppressions-util covers hash_table_3-expected.supp hash_table_3.supp

.%.bin: %.c
	$(CC) -o $@ $(CFLAGS) $+ $(LIBS)
%.supp: .%.bin
	valgrind --leak-check=full --show-leak-kinds=all --gen-suppressions=all --suppressions=../../../src/system.supp ./$< 2>&1 >/dev/null | ../../../trim-valgrind-log.awk >$@
