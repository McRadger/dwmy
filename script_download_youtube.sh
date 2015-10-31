#!/bin/bash

######################################################
#Script to get Youtube videos' MP3 audio
#Description: The script read from csv, with format
#artistName,songName,YoutubeLink
######################################################

installed=`apt-cache pkgnames youtube-dl`

if [ -z "$installed" ]; then
    `sudo wget https://yt-dl.org/downloads/2015.10.13/youtube-dl -O /usr/local/bin/youtube-dl`
    `sudo chmod a+rx /usr/local/bin/youtube-dl`
    `alias youtube-dl=/usr/local/bin/youtube-dl`
fi

installed=`apt-cache pkgnames libav-tools`
if [ -z '$installed' ]; then
	`sudo apt-get install libav-tools`
fi


INPUT=$1
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read artista nombre link
do
		#TODO Create a folder and insert songs over there
		result=`youtube-dl --no-warnings --default-search "ytsearch" --extract-audio --audio-format mp3 --output "$artista-$nombre.%(ext)s" $link`;
done < $INPUT
IFS=$OLDIFS
