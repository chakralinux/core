#!/bin/bash

# build.sh
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

_script_name="build(er)"

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

    echo "Processing: '$pkg'"
    pushd "$pkg" &>/dev/null
    
    #sed -r "s|pkgver=.*|pkgver=$Version|g" -i PKGBUILD
    #sed -r 's|"extra-cmake-modules>=[^"]*"|"extra-cmake-modules>='${Version}'"|g' -i PKGBUILD
    
    #sed '/source ..\/plasma.conf/d' -i PKGBUILD
    
    #sed -r "s|validpgpkeys=.*|validpgpkeys=('2D1D5B0588357787DE9EE225EC94D18F7F05997E'  # Jonathan Riddell\\n              '0AAC775BB6437A8D9AF7A3ACFE0784117FBCE11D'  # Bhushan Shah <bshah@kde.org>\\n              'D07BD8662C56CB291B316EB2F5675605C74E02CF'  # David Edmundson\\n              '1FA881591C26B276D7A5518EEAAF29B42A678C20') # Marco Martin <notmart@gmail.com>|g" -i PKGBUILD
    
    #sed -r 's|cmake_kf5 ..\/\$\{pkgname\}-\$\{pkgver\}|cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \\\n        -DCMAKE_INSTALL_PREFIX=/usr \\\n        -DKDE_INSTALL_LIBDIR=lib \\\n        -DKDE_INSTALL_SYSCONFDIR=/etc \\\n        -DKDE_INSTALL_LIBEXECDIR=lib \\\n        -DUDEV_RULES_INSTALL_DIR=/usr/lib/udev/rules.d \\\n        -DBUILD_TESTING=OFF \\\n        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON "$@"|g' -i PKGBUILD

    #sed -r 's|source=.*|source=("https://download.kde.org/stable/plasma/$pkgver/$pkgname-$pkgver.tar.xz"{,.sig})|g' -i PKGBUILD

    
    #grep -r _pkgname
    #sed -r 's|\$\{_pkgname\}-\$\{pkgver\}.tar.xz|\$\{pkgname\}-\$\{pkgver\}.tar.xz|g' -i PKGBUILD
    
    #sed '/                        SKIP)/d' -i PKGBUILD
    
    sed -r 's|cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo |cmake ..\/${pkgname}-${pkgver} \\\n         -DCMAKE_BUILD_TYPE=RelWithDebInfo |g' -i PKGBUILD
    
    #sed  's|cmake ../${_pkgname}-${pkgver}|cmake ../${pkgname}-${pkgver}|g' -i PKGBUILD
    
    
    
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


#cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \\n        -DCMAKE_INSTALL_PREFIX=/usr \\n        -DKDE_INSTALL_LIBDIR=lib \\n        -DKDE_INSTALL_SYSCONFDIR=/etc \\n        -DKDE_INSTALL_LIBEXECDIR=lib \\n        -DBUILD_TESTING=OFF \\n        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON "$@"\n}

#cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \\\n        -DCMAKE_INSTALL_PREFIX=/usr \\\n        -DKDE_INSTALL_LIBDIR=lib \\\n        -DKDE_INSTALL_SYSCONFDIR=/etc \\\n        -DKDE_INSTALL_LIBEXECDIR=lib \\\n        -DUDEV_RULES_INSTALL_DIR=/usr/lib/udev/rules.d \\\n        -DBUILD_TESTING=OFF \\\n        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON "$@"
