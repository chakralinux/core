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

_script_name="sync down"
_build_arch="$_arch"
_cur_repo=`pwd | awk -F '/' '{print $NF}'`
_needed_functions="config_handling helpers messages"

for subroutine in ${_needed_functions} ; do
    source _buildscripts/functions/${subroutine}
done

if [[ ${_cur_repo} = *-testing ]] && [[ ${_cur_repo} != lib32-testing ]] ; then
    _sync_folder="_testing/"
else
    _sync_folder="_repo/remote/"
fi

title "${_script_name} - $_cur_repo"

check_configs
load_configs

check_rsync
check_accounts

msg "syncing down"
export RSYNC_PASSWORD=$(echo ${_rsync_pass})
if [ "${_sync_folder}" == "_testing/" ] ; then 
  rsync -avh --progress ${_rsync_user}@${_rsync_server}::dev/testing/$_build_arch/* ${_sync_folder}
else
  rsync -avh --progress ${_rsync_user}@${_rsync_server}::${_rsync_dir}/* ${_sync_folder}
fi

newline

title "All done"
newline
