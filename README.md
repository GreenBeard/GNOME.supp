This is a repository of [Valgrind suppression files](http://valgrind.org/docs/manual/manual-core.html#manual-core.suppress) intended to be used to detect memory leaks in GNOME software using [Valgrind](http://valgrind.org). The goals of this project are:

 1. The suppression files should never suppress a real issue (such as a memory leak).
 2. Unavoidable leaks should be suppressed.

    For example, any allocations by [`gdk_display_manager_get()`](https://developer.gnome.org/gdk3/stable/GdkDisplayManager.html#gdk-display-manager-get) can be ignored because there is no API function to clean up after `gdk_display_manager_get()`, and the return semantics are "transfer none".

 3. As many issues as possible should be suppressed without suppressing a real issue.

    The idea here is to cut down on the volume of output, which can be confusing and bury the real issue. For example, if a hash table is created, and many key/value pairs are inserted into this map (causing the hash table to be re-allocated), but the program fails to destroy the hash table, preferably only one leak will be reported.

## Getting started

You will need Valgrind, GNU Make, and `sed`.

 1. Clone the git repository:

    <pre>
    git clone https://github.com/dtrebbien/GNOME.supp.git
    </pre>

 2. Open a terminal and `cd` into `GNOME.supp`.
 3. `make`

GNU Make will generate suppression (SUPP) files in the project root. To use them with Valgrind, pass a [`--suppressions=SUPP_FILE`](http://valgrind.org/docs/manual/manual-core.html#opt.suppressions) option for each suppression file that you would like to use. For example, to use the suppressions in `glib.supp`, you would pass `--suppressions=/path/to/GNOME.supp/glib.supp` to Valgrind.

See the [Valgrind page on the GNOME wiki](https://wiki.gnome.org/Valgrind) for tips on using Valgrind to detect memory leaks in GNOME software.

## License
The contents of the suppression files are [Public Domain](https://creativecommons.org/publicdomain/zero/1.0/legalcode).

Any other code is licensed under the [GNU General Public License](http://www.gnu.org/licenses/gpl.html), either version 3 of the GPL, or (at your option) any later version.
