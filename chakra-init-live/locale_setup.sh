#!/bin/bash
# This is a work in progress, especially locale.gen needs to be adjusted


# $1: the parameter whose value you want to get
# returns: the value of the parameter, if existant
get_bootparam_value()
{
	[ -z "$CMDLINE" ] && CMDLINE="$(< /proc/cmdline)"
	case "$CMDLINE" in *\ $1=*) ;; *) return 1; ;; esac
	local result="${CMDLINE##*$1=}"
	echo ${result%%[ ]*}
}

# returns: the country of the user, if set as kernel parameter
# depends: get_bootparam_value
get_country()
{
	local COUNTRY=`get_bootparam_value lang`
	echo $COUNTRY
}

# depends: get_country
# returns: nothing
# sets the locale as well as timezone and keymap
# TODO only locale working so far
set_locale() {
		# hack to be able to set the locale on bootup
		#
		local COUNTRY=$(get_country)
		[ -n "$COUNTRY" ] || COUNTRY="enus"

		# set a default value, in case something goes wrong, or a language doesn't have
		# good defult settings
		# comment out all locales which we don't need
		sed  -i "s/^/#/g" /etc/locale.gen
		local LOCALE="en_US.utf8"
		local LC_MESSAGE="C"
		local HARDWARECLOCK="UTC"
		local TIMEZONE="Canada/Pacific"
		# copy the keyboard.conf file to it's place
		cp -f /etc/skel/10-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard.conf
		case "$COUNTRY" in
				ast)
						# Asturian
						LOCALE="ast_ES.utf8"
						TIMEZONE="Europe/Madrid"
						KEYMAP="es"
						XKEYMAP="es"
						sed -i "/XkbLayout/ s/us/"es"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				at)
						# Austrian
						LOCALE="de_AT.utf8"
						TIMEZONE="Europe/Vienna"
						KEYMAP="de"
						XKEYMAP="de"
						sed -i "/XkbLayout/ s/us/"de"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				be)
						# Belarusian
						LOCALE="be_BY.utf8"
						TIMEZONE="Europe/Brussels"
						KEYMAP="be"
						XKEYMAP="be"
						sed -i "/XkbLayout/ s/us/"be"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				bg)
						# Bulgarian
						LOCALE="bg_BG.utf8"
						TIMEZONE="Europe/Sofia"
						KEYMAP="bg"
						XKEYMAP="bg"
						sed -i "/XkbLayout/ s/us/"bg"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				ca)
						# Catalan
						LOCALE="ca_ES.utf8"
						TIMEZONE="Europe/Madrid"
						KEYMAP="es"
						XKEYMAP="es"
						sed -i "/XkbLayout/ s/us/"es"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				cs)
						# Czech
						LOCALE="cs_CZ.utf8"
						TIMEZONE="Europe/Prague"
						KEYMAP="cz-lat2"
						XKEYMAP="cz"
						sed -i "/XkbLayout/ s/us/"cz"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				de)
						# German
						LOCALE="de_DE.utf8"
						TIMEZONE="Europe/Berlin"
						KEYMAP="de"
						XKEYMAP="de"
						sed -i "/XkbLayout/ s/us/"de"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				dk)
						# Danish
						LOCALE="da_DK.utf8"
						TIMEZONE="Europe/Copenhagen"
						KEYMAP="dk"
						XKEYMAP="dk"
						sed -i "/XkbLayout/ s/us/"dk"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				el)
						# Greek
						LOCALE="el_GR.utf8"
						TIMEZONE="Europe/Athens"
						KEYMAP="el"
						XKEYMAP="el"
						sed -i "/XkbLayout/ s/us/"el"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				engb)
						# British
						LOCALE="en_GB.utf8"
						TIMEZONE="Europe/London"
						KEYMAP="gb"
						XKEYMAP="uk"
						sed -i "/XkbLayout/ s/us/"gb"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				ennz)
						# New Zealand
						LOCALE="en_NZ.utf"
						HARMEZONE="Pacific/Auckland"
						KEYMAP="us"
						XKEYMAP="us"
						sed -i "/XkbLayout/ s/us/"us"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				enus)
						# English
						LOCALE="en_US.utf8"
						TIMEZONE="Canada/Pacific"
						KEYMAP="us"
						XKEYMAP="us"
						sed -i "/XkbLayout/ s/us/"us"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				es)
						# Spain
						LOCALE="es_ES.utf8"
						TIMEZONE="Europe/Madrid"
						KEYMAP="es"
						XKEYMAP="es"
						sed -i "/XkbLayout/ s/us/"es"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				esar)
						# Argetina
						LOCALE="es_AR.utf8"
						TIMEZONE="America/Argentina"
						KEYMAP="la-latin1"
						XKEYMAP="la-latin1"
						sed -i "/XkbLayout/ s/us/"es"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				eu)
						# Basque
						LOCALE="eu_ES.utf8"
						TIMEZONE="Europe/Madrid"
						KEYMAP="es"
						XKEYMAP="es"
						sed -i "/XkbLayout/ s/us/"es"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				fi)
						# Finland
						LOCALE="fi_FI.utf8"
						TIMEZONE="Europe/Helsinki"
						KEYMAP="fi"
						XKEYMAP="fi"
						sed -i "/XkbLayout/ s/us/"fi"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				fr)
						# France
						LOCALE="fr_FR.utf8"
						TIMEZONE="Europe/Paris"
						KEYMAP="fr"
						XKEYMAP="fr"
						sed -i "/XkbLayout/ s/us/"fr"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				gl)
						# Galician
						LOCALE="gl_ES.utf8"
						TIMEZONE="Europe/Madrid"
						KEYMAP="es"
						XKEYMAP="es"
						sed -i "/XkbLayout/ s/us/"es"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				hu)
						# Hungary
						LOCALE="hu_HU.utf8"
						TIMEZONE="Europe/Budapest"
						KEYMAP="hu"
						XKEYMAP="hu"
						sed -i "/XkbLayout/ s/us/"hu"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				hr)
						# Croatian
						LOCALE="hr_HR.utf8"
						TIMEZONE="Europe/Zagreb"
						KEYMAP="hr"
						XKEYMAP="hr"
						sed -i "/XkbLayout/ s/us/"hr"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				it)
						# Italy
						LOCALE="it_IT.utf8"
						TIMEZONE="Europe/Rome"
						KEYMAP="it"
						XKEYMAP="it"
						sed -i "/XkbLayout/ s/us/"it"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				ja)
						# Japanese
						LOCALE="ja_JP.utf8"
						TIMEZONE="Asia/Tokyo"
						KEYMAP="us"
						XKEYMAP="us"
						sed -i "/XkbLayout/ s/us/"us"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				nl)
						# Dutch
						LOCALE="nl_NL.utf8"
						TIMEZONE="Europe/Amsterdam"
						KEYMAP="us"
						XKEYMAP="us"
						sed -i "/XkbLayout/ s/us/"us"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				nlbe)
						# Belgium
						LOCALE="nl_BE.utf8"
						TIMEZONE="Europe/Brussels"
						KEYMAP="be"
						XKEYMAP="be"
						sed -i "/XkbLayout/ s/us/"be"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				no)
						# Norway
						LOCALE="nb_NO.utf8"
						TIMEZONE="Europe/Oslo"
						KEYMAP="no"
						XKEYMAP="no"
						sed -i "/XkbLayout/ s/us/"no"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				pl)
						# Poland
						LOCALE="pl_PL.utf8"
						TIMEZONE="Europe/Warsaw"
						KEYMAP="pl"
						XKEYMAP="pl"
						CONSOLEFONT="lat2-16.psfu.gz"
						sed -i "/XkbLayout/ s/us/"pl"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				ptbr)
						# Brazilian Portuguese
						LOCALE="pt_BR.utf8"
						TIMEZONE="America/Sao_Paulo"
						KEYMAP="br-abnt2"
						XKEYMAP="pt"
						sed -i "/XkbLayout/ s/us/"br"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				ru)
						# Russia
						LOCALE="ru_RU.utf8"
						TIMEZONE="Europe/Moscow"
						KEYMAP="ru"
						XKEYMAP="ru"
						sed -i "/XkbLayout/ s/us/"ru"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				sk)
						# Slovak
						LOCALE="sk_SK.utf8"
						TIMEZONE="Europe/Bratislava"
						KEYMAP="sk"
						XKEYMAP="sk"
						sed -i "/XkbLayout/ s/us/"sk"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				sl)
						# Slovenian
						LOCALE="sl_SI.utf8"
						TIMEZONE="Europe/Ljubljana"
						KEYMAP="slovene"
						XKEYMAP="si"
						sed -i "/XkbLayout/ s/us/"si"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				sr)
						# Serbian
						LOCALE="sr_RS.utf8"
						TIMEZONE="Europe/Belgrade"
						KEYMAP="sr"
						XKEYMAP="sr"
						sed -i "/XkbLayout/ s/us/"sr"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				sv)
						# Swedish
						LOCALE="sv_SE.utf8"
						TIMEZONE="Europe/Stockholm"
						KEYMAP="se"
						XKEYMAP="se"
						sed -i "/XkbLayout/ s/us/"se"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				tr)
						# Turkish
						LOCALE="tr_TR.utf8"
						TIMEZONE="Europe/Istanbul"
						KEYMAP="tr"
						XKEYMAP="trq"
						sed -i "/XkbLayout/ s/us/"tr"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				vcia)
						# Catalan (valencia)
						LOCALE="ca_ES.utf8@valencia"
						TIMEZONE="Europe/Madrid"
						KEYMAP="es"
						XKEYMAP="es"
						sed -i "/XkbLayout/ s/us/"es"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				zhcn)
						# Simplified Chinese
						LOCALE="zh_CN.utf8"
						TIMEZONE="Asia/Shanghai"
						KEYMAP="us"
						XKEYMAP="us"
						sed -i "/XkbLayout/ s/us/"us"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				zhhk)
						# Traditional Chinese (Hong Kong)
						LOCALE="zh_HK.utf8"
						TIMEZONE="Asia/Hong Kong"
						KEYMAP="us"
						XKEYMAP="us"
						sed -i "/XkbLayout/ s/us/"us"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				zhtw)
						# Traditional Chinese (Taiwan)
						LOCALE="zh_TW.utf8"
						TIMEZONE="Asia/Taipei"
						KEYMAP="us"
						XKEYMAP="us"
						sed -i "/XkbLayout/ s/us/"us"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
				*)
						# American
						LOCALE="en_US.utf8"
						TIMEZONE="Canada/Pacific"
						KEYMAP="us"
						XKEYMAP="us"
						sed -i "/XkbLayout/ s/us/"us"/" /etc/X11/xorg.conf.d/10-keyboard.conf
						;;
		esac
		# the following sed line uncomments the line corresponding to the users language
		# in /etc/locale.gen
		# -i -r: edit inplace, use extended regex; $TLANG is the language variable
		# match outcommented lines containing the language and UTF-8, store everything
		# except the # in a group and replace it with this group (that's the \1)
		local TLANG=${LOCALE%.*} # remove everything after the ., including the dot from LOCALE
		sed -i -r "s/#(.*${TLANG}.*UTF-8)/\1/g" /etc/locale.gen
		sed -i -r "s/#(en_US.*UTF-8)/\1/g" /etc/locale.gen
		echo "LANG=$LOCALE" > /etc/locale.conf
		echo "LC_MESSAGES=$LOCALE" >> /etc/locale.conf
		# generate LOCALE
		locale-gen

		#--------------locale is now set up, now setting up timezone---------------#
		# set timezone
		ln -s /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
		# set hardware clock to utc 
		#TODO should this be changed when we detect Windows?
		hwclock --systohc --utc
}
