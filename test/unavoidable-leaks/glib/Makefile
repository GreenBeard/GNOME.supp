SUPP_FILES = \
get_application_name.supp \
get_home_dir.supp \
get_host_name.supp \
get_prgname.supp \
get_real_name.supp \
get_system_config_dirs.supp \
get_system_data_dirs.supp \
get_tmp_dir.supp \
get_user_cache_dir.supp \
get_user_config_dir.supp \
get_user_data_dir.supp \
get_user_name.supp \
get_user_runtime_dir.supp
# get_user_special_dir.supp is omitted for now.
# See KDE Bug 343306 - OS X 10.10: UNKNOWN mach_msg unhandled MACH_SEND_TRAILER option
# https://bugs.kde.org/show_bug.cgi?id=343306#c3

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
	valgrind-suppressions-util covers ../../../src/glib/glib-Miscellaneous-Utility-Functions.supp $(patsubst test_%,%.supp,$@)

.%.bin: %.c
	$(CC) -g -o $@ $(CFLAGS) $+ $(LIBS)
%.supp: .%.bin ../../../src/system.supp
	valgrind --num-callers=100 --leak-check=full --show-leak-kinds=all --gen-suppressions=all --suppressions=../../../src/system.supp ./$< 2>&1 >/dev/null | ../../../trim-valgrind-log.awk >$@
