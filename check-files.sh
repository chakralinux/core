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



_script_name="check files"
_cur_repo=$(pwd | awk -F '/' '{print $NF}')
_build_arch="$_arch"

source _buildscripts/functions/config_handling
source _buildscripts/functions/helpers
source _buildscripts/functions/messages

# Determine the sync folder
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

question() {
    echo -e -n "\033[1;32m::\033[1;0m\033[1;0m $1\033[1;0m"
}

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
    pushd ${_sync_folder} &>/dev/null
        rm -rf ${remove_list}
    popd &>/dev/null
}

sync_down

# Get the file list in the server
export RSYNC_PASSWORD=$(echo ${_rsync_pass})
if [ "${_sync_folder}" == "_testing/" ] ; then 
    repo_files=`rsync -avh --list-only ${_rsync_user}@${_rsync_server}::dev/testing/$_arch/* | cut -d ":" -f 3 | cut -d " " -f 2`
else
    repo_files=`rsync -avh --list-only ${_rsync_user}@${_rsync_server}::${_rsync_dir}/* | cut -d ":" -f 3 | cut -d " " -f 2`
fi

# Get the file list in sync folder
local_files=`ls -a ${_sync_folder}* | cut -d "/" -f 3`

# Get the list of files to remove
remove_list=""
for _file in ${local_files} ; do
    file_exist="false"
    for _compare_file in ${repo_files} ; do
        if [ "${_file}" = "${_compare_file}" ] ; then
            file_exist="true"
        fi
    done

    if [ "${file_exist}" = "false" ] ; then
        remove_list="${remove_list} ${_file}"
    fi
done

if [ "${remove_list}" != "" ] ; then
    msg "The following packages in _repo/remote don't exist in the sever:"
    newline
    echo "${remove_list}"
    newline
    question "Do you want to remove the package(s)? (y/n)"
    while true ; do
        read yn

        case ${yn} in
            [yY]* )
                newline ;
                remove_packages ;
                break ;
            ;;

            [nN]* )
                newline ;
                title "The files will be keeped..." ;
                newline ;
                break ;
            ;;

            * )
                echo "Enter (y)es or (n)o" ;
            ;;
        esac
    done
fi

title "All done"
newline
