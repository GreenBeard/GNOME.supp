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

#include <glib.h>
#include <stdlib.h>

int main()
{
    GHashTable *hash = g_hash_table_new(g_str_hash, g_str_equal);
    //g_hash_table_destroy(hash); // purposely commented out to introduce a memory leak
    return EXIT_SUCCESS;
}