#!/usr/bin/awk -f

# Similar to this script:
# https://wiki.wxwidgets.org/Parse_valgrind_suppressions.sh
# .. except that this just trims out the lines of the Valgrind log that are not suppressions.

BEGIN { reading_suppression = 0 }

/^{/ {
    reading_suppression = 1; i = 0; next
}

/^}/ {
    if (reading_suppression) {
        reading_suppression = 0

        print "{"
        for (n = 1; n <= i; ++n) {
            print supparray[n]
        }
        print "}"

        delete supparray
    }
}

{
    if (reading_suppression) {
        supparray[++i] = $0
    }
}
