#!/bin/bash
#
# Copyright (c) 2013 - Manuel Tortosa <manutortosa@chakra-project.org>
#
# This script is released under the LGPL2+ 


# $1: the parameter whose value you want to get
# returns: the value of the parameter, if existant
get_bootparam_value() {
  [ -z "$CMDLINE" ] && CMDLINE="$(< /proc/cmdline)"
  case "$CMDLINE" in *\ $1=*) ;; *) return 1; ;; esac
  local result="${CMDLINE##*$1=}"
  echo ${result%%[ ]*}
}

# returns: the country of the user, if set as kernel parameter
get_country() {
  local COUNTRY=$(get_bootparam_value lang)
  echo $COUNTRY
}

get_keyboard() {
  local KEYBOARD=$(get_bootparam_value keytable)
  echo $KEYBOARD
}

# sets the locale as well the keymap
set_locale() {
  # hack to be able to set the locale on bootup
  local LOCALE=$(get_country)
  local KEYMAP=$(get_keyboard)		
		
  # set a default value, in case something goes wrong, or a language doesn't have
  # good defult settings
  [ -n "$LOCALE" ] || LOCALE="en_US"
  [ -n "$KEYMAP" ] || KEYMAP="us"

  # comment out all locales which we don't need
  sed  -i "s/^/#/g" /etc/locale.gen
				
  # copy the keyboard.conf file to it's place
  cp -f /etc/skel/10-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard.conf
  sed -i "/XkbLayout/ s/us/"${KEYMAP}"/" /etc/X11/xorg.conf.d/10-keyboard.conf
  echo "KEYMAP=\"${KEYMAP}\"" >> /etc/vconsole.conf
		
  # set systemwide language
  echo "LANG=${LOCALE}.UTF-8" > /etc/locale.conf
  echo "LC_MESSAGES=${LOCALE}.UTF-8" >> /etc/locale.conf
	
  # generate LOCALE
  local TLANG=${LOCALE%.*} # remove everything after the ., including the dot from LOCALE
  sed -i -r "s/#(.*${TLANG}.*UTF-8)/\1/g" /etc/locale.gen
  # add also American English as safe default
  sed -i -r "s/#(en_US.*UTF-8)/\1/g" /etc/locale.gen
  locale-gen
}

