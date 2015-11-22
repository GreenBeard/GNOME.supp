// Copyright (C) 2015  Daniel Trebbien
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include <assert.h>
#include <glib.h>
#include <stdlib.h>

gchar *make_key()
{
    return g_strdup("some key");
}

gchar *make_value()
{
    return g_strdup("some value");
}

int main()
{
    GHashTable *hash = g_hash_table_new_full(g_str_hash, g_str_equal, NULL, g_free); // key_destroy_func purposely NULL to introduce a memory leak.

    gboolean insert_res = g_hash_table_insert(hash, make_key(), make_value());
    assert(insert_res);
    g_hash_table_destroy(hash);

    return EXIT_SUCCESS;
}
