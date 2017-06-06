#!/bin/bash

# This is a simple script which import all Chakra keys
# this script is licensed under the GPL
#
# Copyright (c) 2017 - Luca Giambonini <almack@chakralinux.org>


import_trusted() {
    gpg --with-colons --fingerprint $1 | sed -E -n -e 's/^fpr:::::::::([0-9A-F]+):$/\1:4:/p' | head -n 1
}

# some cleanup
rm chakra.gpg
touch chakra.gpg
rm  chakra-trusted
touch  chakra-trusted

# Giuseppe's key
gpg --recv-keys --keyserver keys.gnupg.net 0x26C56140
gpg --armor --export jiveaxe@gmail.com >> chakra.gpg
import_trusted "0x26C56140" >> chakra-trusted
# Weng Xuetian's key
gpg --recv-keys --keyserver keys.gnupg.net 0xBF2412F9
gpg --armor --export wengxt@gmail.com >> chakra.gpg
import_trusted "0xBF2412F9" >> chakra-trusted
# Neo's key
gpg --recv-keys --keyserver keys.gnupg.net 0x02238B03
gpg --armor --export tetris4@gmail.com >> chakra.gpg
import_trusted "0x02238B03" >> chakra-trusted
# Luca's key
gpg --recv-keys --keyserver keys.gnupg.net 0x3DB6614F
gpg --armor --export gluca86@gmail.com >> chakra.gpg
import_trusted "0x3DB6614F" >> chakra-trusted
# Jeff's keys
gpg --recv-keys --keyserver keys.gnupg.net 0xB6611E8A
gpg --armor --export s8321414@gmail.com >> chakra.gpg
import_trusted "0xB6611E8A" >> chakra-trusted
# Ryan's key
gpg --recv-keys --keyserver keys.gnupg.net 0xD417608D
gpg --armor --export ryan@rshipp.com >> chakra.gpg
import_trusted "0xD417608D" >> chakra-trusted
# Inkane's key
gpg --recv-keys --keyserver keys.gnupg.net 0xF906E3F4
gpg --armor --export 0inkane@googlemail.com >> chakra.gpg
import_trusted "0xF906E3F4" >> chakra-trusted
# Gallaecio's key
gpg --recv-keys --keyserver keys.gnupg.net 0x82AC496A
gpg --armor --export adriyetichaves@gmail.com >> chakra.gpg
import_trusted "0x82AC496A" >> chakra-trusted
# FranzMari's key
gpg --recv-keys --keyserver keys.gnupg.net 0x4CA5A1FF
gpg --armor --export framari@openmailbox.org >> chakra.gpg
import_trusted "0x4CA5A1FF" >> chakra-trusted
# BrLi's key
gpg --recv-keys --keyserver keys.gnupg.net 0xC51B9BC2
gpg --armor --export brli@chakralinux.org >> chakra.gpg
import_trusted "0xC51B9BC2" >> chakra-trusted
# gnastyle's key
gpg --recv-keys --keyserver keys.gnupg.net 0x46B51A79
gpg --armor --export gnastyle >> chakra.gpg
import_trusted "0x46B51A79" >> chakra-trusted
