#!/bin/bash

#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>
#
#   (c) 2010 - Manuel Tortosa <manutortosa[at]chakra-project[dot]org>

#
# global vars
#
_script_name="Remove Package(s)"
_cur_repo=`pwd | awk -F '/' '{print $NF}'`
_needed_functions="config_handling helpers messages"
_args=`echo $1`
_build_arch="$_arch"

# helper functions

for subroutine in ${_needed_functions} ; do
    source _buildscripts/functions/${subroutine}
done

# Determine the sync folder
if [[ ${_cur_repo} = *-testing ]] && [[ ${_cur_repo} != lib32-testing ]] ; then
    _sync_folder="_testing/"
else
    _sync_folder="_repo/remote/"
fi

#
# main
#

sync_down()
{
    msg "syncing down"
    export RSYNC_PASSWORD=$(echo ${_rsync_pass})
    if [ "${_sync_folder}" == "_testing/" ] ; then 
	rsync -avh --progress ${_rsync_user}@${_rsync_server}::dev/testing/$_build_arch/* ${_sync_folder}
    else
	rsync -avh --progress ${_rsync_user}@${_rsync_server}::${_rsync_dir}/* ${_sync_folder}
    fi
}

remove_packages()
{
    # remove the package(s) from sync folder
    msg "removing the packages(s) from ${_sync_folder}"
    pushd $_sync_folder &>/dev/null
        rm -rf ${_pkgz_to_remove}
    popd &>/dev/null
}

sync_up()
{
    # create new pacman database
    msg "creating pacman database"
    rm -rf ${_sync_folder}*.db.tar.*
    pushd ${_sync_folder}
	if [ "${_sync_folder}" == "_testing/" ] ; then 
	    repo-add testing.db.tar.gz *.pkg.*
	else
	    repo-add ${_cur_repo}.db.tar.gz *.pkg.*
	fi
    popd

    # sync local -> server, removing the packages
    msg "sync local -> server"
    if [ "${_sync_folder}" == "_testing/" ] ; then 
	rsync -avh --progress --delay-updates --delete-after ${_sync_folder} ${_rsync_user}@${_rsync_server}::dev/testing/$_arch/
    else
	rsync -avh --progress --delay-updates --delete-after ${_sync_folder} ${_rsync_user}@${_rsync_server}::${_rsync_dir}
    fi
}


#
# startup
#

clear

title "${_script_name} - $_cur_repo-$_build_arch"

if [ "${_args}" = "" ] ; then
    error " !! You need to specify a target to remove,"
    error "    single names like \"attica\" or wildcards (*) are allowed."
    newline
    exit 1
fi

check_configs
load_configs

check_rsync
check_accounts

# First get the actual packages from the repo
sync_down

# Generate the list of packages to remove
newline
_args=${_args}*
_pkgz_to_remove=`ls ${_sync_folder}${_args} | cut -d/ -f3`

if [ "${_pkgz_to_remove}" = "" ] ; then
    exit
fi

warning "The following packages will be removed:"
newline
echo "${_pkgz_to_remove}"

newline
msg "Do you really want to remove the package(s)? (y/n)"

while true ; do
    read yn

    case $yn in
        [yY]* )
            newline ;
            remove_packages ;
            sync_up ;
            newline ;
            title "All done" ;
            newline ;
            break
        ;;

        [nN]* )
            exit
        ;;

        q* )
            exit
        ;;

        * )
            echo "Enter (y)es or (n)o"
        ;;
    esac
done
