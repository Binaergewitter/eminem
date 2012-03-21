#!/bin/sh
set -euf
[ "x${1:-}" = "x-h" ] && echo "usage: $0 [-h|live]" && echo "   -h      this message" && echo "   live    do it live" && exit 0
CFG=binaergewiiter_full.cfg
SM=BGT
INPLACE=
LAST=`sed -n "s/name=$SM\(.*\)/\1/p" $CFG | head -1`
NOW=`printf %03d $(($LAST+1))`
if [ "x${1:-}" != "xlive" ] 
then 
	echo "this is what your config looks like"
	sed -e "s/$SM$LAST/$SM$NOW/" $CFG
else
	echo "We are doing it live!"
	echo "CURRENT SESSION IS $SM$LAST"
	sed -i "s/$SM$LAST/$SM$NOW/" $CFG
	screen sudo darkice -c $CFG
fi
