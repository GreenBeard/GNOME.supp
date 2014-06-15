glib_supp_FILES := $(wildcard src/glib/*.supp)
gio_supp_FILES := $(wildcard src/gio/*.supp)
pango_supp_FILES := $(wildcard src/pango/*.supp)
gail_supp_FILES := $(wildcard src/gail/*.supp)
gdk_supp_FILES := $(wildcard src/gdk/*.supp)
gtk_supp_FILES := $(wildcard src/gtk+/*.supp)
gtk3_supp_FILES := build/gtk.supp $(wildcard src/gtk+/3.x/*.supp)
gtksourceview_supp_FILES := $(wildcard src/gtksourceview/*.supp)

BASE_GENERATED_SUPP_FILES = build/glib.supp build/gio.supp build/pango.supp build/gail.supp build/gdk.supp build/gtk3.supp build/gtksourceview.supp
base_supp_FILES = src/glibc.supp src/fontconfig.supp $(BASE_GENERATED_SUPP_FILES)

ALL_GENERATED_SUPP_FILES = $(BASE_GENERATED_SUPP_FILES) build/gtk.supp build/base.supp

.PHONY: all clean

all: $(ALL_GENERATED_SUPP_FILES)

clean:
	$(RM) -r build
	mkdir -p build
	touch build/.keep

build/glib.supp: $(glib_supp_FILES)
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
