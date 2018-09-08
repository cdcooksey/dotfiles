#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi

FILE=$1
FILE_NAME="${FILE%.*}"
EXT="${FILE##*.}"
NEW_FILE_NAME="${FILE_NAME}.mp4"

echo -n "Convert $FILE to $NEW_FILE_NAME (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo 'Converting...'
else
    echo "Quitting"
    exit
fi


if [ $EXT = 'mp4' ]
then
    echo 'Already mp4. Quitting'
    exit
fi

if [ $EXT = 'mkv' ]
then
    echo 'mkv detected'
    sudo ffmpeg -i $FILE -c copy $NEW_FILE_NAME && echo "Deleting $FILE..." && sudo rm $FILE
fi

if [ $EXT = 'avi' ]
then
    echo 'avi detected'
    sudo ffmpeg -i $FILE -c:v libx264 -c:a copy $NEW_FILE_NAME && echo "Deleting $FILE..." && sudo rm $FILE
fi

echo 'Done'
