#! /bin/sh -e
# tup - A file-based build system
#
# Copyright (C) 2009-2012  Mike Shal <marfey@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# This was discovered while trying to build ncurses. Because of the pattern of
# file accesses in a shell script, we end up with a file that has its modify
# flag set after a successful update. That's annoying.

. ./tup.sh
check_no_windows shell
cat > Tupfile << HERE
: |> echo hey > %o && ./foo.sh %o |> out.txt
HERE

# This script mimics something stupid done in ncurses' edit_cfg.sh
cat > foo.sh << HERE
mv \$1 tmp
cat tmp > \$1
rm tmp
HERE
chmod +x foo.sh
tup touch Tupfile foo.sh
update

eotup
