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
# setup
#
_script_name="sync up nodb"
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

    # sync local -> server
    msg "upload pkgs to server"
    if [ "${_sync_folder}" == "_testing/" ] ; then 
	rsync -avh --progress --delay-updates ${_sync_folder} ${_rsync_user}@${_rsync_server}::dev/testing/$_arch/
    else
	rsync -avh --progress --delay-updates ${_sync_folder} ${_rsync_user}@${_rsync_server}::${_rsync_dir}
    fi

}



title "${_script_name} - $_cur_repo"

check_configs
load_configs

check_rsync
check_accounts

time sync_up
newline

title "All done"
newline
