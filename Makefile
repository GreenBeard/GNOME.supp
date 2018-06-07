glib_supp_FILES := $(wildcard src/glib/*.supp)
gobject_supp_FILES := $(wildcard src/gobject/*.supp)
gio_supp_FILES := $(wildcard src/gio/*.supp)
pango_supp_FILES := $(wildcard src/pango/*.supp)
gail_supp_FILES := $(wildcard src/gail/*.supp)
gdk_supp_FILES := $(wildcard src/gdk/*.supp)
gtk_supp_FILES := $(wildcard src/gtk+/*.supp)
gtk3_supp_FILES := build/gtk.supp $(wildcard src/gtk+/3.x/*.supp)
gtksourceview_supp_FILES := $(wildcard src/gtksourceview/*.supp)

BASE_GENERATED_SUPP_FILES = build/glib.supp build/gobject.supp build/gio.supp build/pango.supp build/gail.supp build/gdk.supp build/gtk3.supp build/gtksourceview.supp
base_supp_FILES = src/glibc.supp src/fontconfig.supp $(BASE_GENERATED_SUPP_FILES)

ALL_GENERATED_SUPP_FILES = $(BASE_GENERATED_SUPP_FILES) build/gtk.supp build/base.supp

.PHONY: all clean test

all: $(ALL_GENERATED_SUPP_FILES)

clean:
	$(RM) src/empty.c src/.empty.bin
	$(RM) $(ALL_GENERATED_SUPP_FILES)
	$(MAKE) -C test clean

test: all
	$(MAKE) -C test test

build/glib.supp: $(glib_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/gobject.supp: $(gobject_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/gio.supp: $(gio_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/pango.supp: $(pango_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/gail.supp: $(gail_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/gdk.supp: $(gdk_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/gtk.supp: $(gtk_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/gtk3.supp: $(gtk3_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/gtksourceview.supp: $(gtksourceview_supp_FILES)
	cat -- $^ | sed '/^#/d' >$@
build/base.supp: Makefile $(base_supp_FILES)
	cat -- $(filter %.supp,$^) | sed '/^#/d' >$@

src/empty.c:
	echo '#include <stdlib.h>' >$@
	echo 'int main() { return EXIT_SUCCESS; }' >>$@
src/.empty.bin: src/empty.c
	$(CC) -o $@ $(shell pkg-config --cflags glib-2.0) $+ $(shell pkg-config --libs glib-2.0)
src/system.supp: src/.empty.bin
	valgrind --leak-check=full --show-leak-kinds=all --gen-suppressions=all ./$< 2>&1 >/dev/null | ./trim-valgrind-log.awk >$@
