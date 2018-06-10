#!/bin/bash

# kdeupdate.sh
#
# Copyright © 2018 Luca Giambonini <almack@chakralinux.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

_script_name="kde update"

# load functions
for subroutine in $_needed_functions ; do
  source ~/bin/functions/$subroutine
done

build()
{
  while read -r pkg; do
    [[ $pkg =~ ^[:blank:]*$ ]] && continue

    local comment_re="^[:blank:]*#"
    [[ $pkg =~ $comment_re ]] && continue

    msg "Processing: '$pkg'"
    pushd "$pkg" &>/dev/null

    sed -r "s|pkgver=.*|pkgver=$Version|g" -i PKGBUILD
    #sed -r 's|_url=.*|_url="$Server${pkgver%.*}/${_pkgname}-${pkgver}.tar.xz"|g' -i PKGBUILD

    popd &>/dev/null
  done < "$1"
}

title "$_script_name"

if [ ! -f $1.conf ]; then
    echo "$1.conf: File not found!"
    exit 1
fi

# load the configurations
source $1.conf

time build "$1.order"

