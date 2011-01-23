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


_script_name="sync up"
_cur_repo=`pwd | awk -F '/' '{print $NF}'`

source _buildscripts/functions/config_handling
source _buildscripts/functions/helpers
source _buildscripts/functions/messages

if [[ ${_cur_repo} = *-testing ]] && [[ ${_cur_repo} != lib32-testing ]] ; then
    _sync_folder="_testing/"
else
    _sync_folder="_repo/remote/"
fi

sync_up()
{
    export RSYNC_PASSWORD=$(echo ${_rsync_pass})

    # move new packages from $ROOT/repos/$REPO/build into thr repo dir
    msg "adding new packages"
    mv -v _repo/local/*.pkg.* ${_sync_folder}

    # run repo-clean on it
    msg "running repo-clean"
    repo-clean -m c -s ${_sync_folder}

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

    # sync local -> server
    msg "sync local -> server"
    if [ "${_sync_folder}" == "_testing/" ] ; then 
	rsync -avh --progress --delay-updates --delete-after ${_sync_folder} ${_rsync_user}@${_rsync_server}::dev/testing/$_build_arch/
    else
	rsync -avh --progress --delay-updates --delete-after _repo/remote/ ${_rsync_user}@${_rsync_server}::${_rsync_dir}
    fi
}



title "${_script_name} - $_cur_repo"

check_configs
load_configs

check_rsync
check_accounts

time sync_up

title "All done"
newline
