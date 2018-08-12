#!/usr/bin/env bash
#
# Creates a banner at the top line of a terminal window
# Copyright © 2018 Chris Waltrip <chris@walt.rip>
# This software is licensed under the MIT License.
# See LICENSE for the full-text of the license.

# Notes about escape sequences

# \e[s 					- Save current cursor position
# \e[1;1H				- Move cursor to 1,1 (from upper-left corner)
# \e[38;...;48;...;#m 	- Set foreground and background colors (in ellipses)
# \e[K 					- Clear everything to end of line (w/ background color)
# %*s 					- String to be inserted
# \e[0m 				- Reset everything to normal (colors, styles, etc.)
# \e[u 					- Return cursor to saved position


# TODO(Chris):  Make init set a single readonly text and color combination?
# TODO(Chris):  Can you trap on Ctrl+L and clear to push prompt to second line?

#U=""
#C=""
#S=""
#TS=""
#SCI=""
#CLASS=""

U_TEXT="UNCLASSIFIED"
FOUO_TEXT="UNCLASSIFIED//FOR OFFICIAL USE ONLY"
C_TEXT="CONFIDENTIAL"
S_TEXT="SECRET"
TS_TEXT="TOP SECRET"
SCI_TEXT='TOP SECRET//SCI'
CLASS_TEXT="CLASSIFIED"

init() {
	# Determine if 8-bit or 24-bit colors are supported
	if [[ "${COLORTERM}" =~ ^(truecolor|24bit)$ ]]; then
		init_truecolor;
	elif [[ $(tput colors) == "256" ]] || [[ "${TERM}" =~ ^(xterm-256color) ]]; then
		init_256color;
	else
		init_8color;
	fi
}

init_truecolor() {
	# <FG> = 38, <BG> = 48
	# \e[38;2;<R>;<G>;<B>;48;2;<R>;<G>;<B>m"
	U="\e[38;2;255;255;255;48;2;0;122;51m"
	C="\e[38;2;255;255;255;48;2;0;51;160m"
	S="\e[38;2;255;255;255;48;2;200;16;46m"
	TS="\e[38;2;255;255;255;48;2;255;103;31m"
	SCI="\e[38;2;0;0;0;48;2;247;234;72m"
	CLASS="\e[38;2;0;0;0;48;2;193;167;226m"
}

init_256color() {
	# The current release of PuTTY (0.70) doesn't support truecolor (however, 
	# the commit a4cbd3d adds this support), so replace some of the 
	# defined colors with the exact values that should be used.
	tput initc  22 00 7a 33 # UNCLASSIFIED
	tput initc  20 00 33 a0 # CONFIDENTIAL
	tput initc 160 c8 10 2e # SECRET
	tput initc 202 ff 67 1f # TOP SECRET
	tput initc 220 f7 ea 48 # CLASSIFIED SCI
	tput initc 147 c1 a7 e2 # CLASSIFIED - Should be 141 or 147 (probably 147)
	tput initc 232 00 00 00 # Black
	tput initc 255 ff ff ff # White

	U="\e[38;5;255;48;5;22m"
	C="\e[38;5;255;48;5;20m"
	S="\e[38;5;255;48;5;160m"
	TS="\e[38;5;255;48;5;202m"
	SCI="\e[38;5;232;48;5;220m"
	CLASS="\e[38;5;232;48;5;147m"
}

init_8color() {
	# TODO(Chris):  Decide how to implement later.
	echo "I'm a placeholder"
}

banner_text() {
	echo "$(printf "\e[s\e[1;1H${1}\e[K%*s\e[0m\e[u" $(( (${#2} + $(tput cols)) / 2 )) "${2}")"
}

banner() {
	export PS1="\["$(banner_text "${1}" "${2}")"\]\u@\h \w\$ "
}

u_banner() {
	banner "${U}" "${U_TEXT}"
}

fouo_banner() {
	banner "${U}" "${FOUO_TEXT}"
}

c_banner() {
	banner "${C}" "${C_TEXT}"
}

s_banner() {
	banner "${S}" "${S_TEXT}"
}

ts_banner() {
	banner "${TS}" "${TS_TEXT}"
}

sci_banner() {
	banner "${SCI}" "${SCI_TEXT}"
}

class_banner() {
	banner "${CLS}" "${CLASS_TEXT}"
}

init