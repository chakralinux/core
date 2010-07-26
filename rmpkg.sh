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
# Global setup
#
_script_name="Remove Package(s)"
_build_arch="$_arch"
_cur_repo=`pwd | awk -F '/' '{print $NF}'`
_needed_functions="config_handling helpers messages"

GET_PKGS=`echo $1`

# Load functions
for subroutine in ${_needed_functions}
do
    source _buildscripts/functions/${subroutine}
done

question() {
	local mesg=$1; shift
	echo -e -n "\033[1;32m::\033[1;0m\033[1;0m ${mesg}\033[1;0m"
}

#
# main
#
sync_down()
{
	# download all the packages from the repo
	title2 "syncing down, please wait..."
        export RSYNC_PASSWORD=`echo $_rsync_pass`
        rsync -avh --progress $_rsync_user@$_rsync_server::$_rsync_dir/* _repo/remote/
}

remove_packages()
{
	# remove the package(s) from _repo/remote
	title2 "removing the packages(s) from _repo/remote"
	pushd _repo/remote &>/dev/null
	rm -rf $PKGS_TO_REMOVE
	popd &>/dev/null
}

sync_up()
{
	# create new pacman database
        title2 "creating pacman database, please wait..."
	rm -rf _repo/remote/*.db.tar.gz &>/dev/null
        pushd _repo/remote/ &>/dev/null
        repo-add $_cur_repo.db.tar.gz *.pkg.* &>/dev/null
        popd &>/dev/null

        # sync local -> server, removing the packages
        title2 "syncing up"
        rsync -avh --progress --delay-updates --delete-after _repo/remote/ $_rsync_user@$_rsync_server::$_rsync_dir
}


#
# startup
#
clear
title "${_script_name} - $_cur_repo-$_build_arch"

if [ "$GET_PKGS" = "" ] ; then
	error "You need to especify a target to remove,"
	error "single names like \"attica\" or wildcards (*) are allowed." 
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
GET_PKGS=$GET_PKGS-*
PKGS_TO_REMOVE=`ls _repo/remote/$GET_PKGS | cut -d "/" -f3`

if [ "$PKGS_TO_REMOVE" = "" ] ; then
	error "exiting..."
	exit
fi

title2 "The following packages will be removed:"
newline
echo "$PKGS_TO_REMOVE"

newline
question "Do you really want to remove the package(s)? (y/n)"
while true; do
	read yn
	case $yn in
		y* | Y* ) 
		newline ;
		remove_packages ;
		sync_up ;
		newline ;
		title "All done" ;
		newline ;
		break 
		;;
		
		[nN]* )   
		newline ;
		title "Removal avorted, exiting..." ; 
		newline ;
		break 
		;;
		
		q* ) 
		exit 
		;;
		
		* ) 
		echo "Enter yes or no" 
		;;
	esac
done

