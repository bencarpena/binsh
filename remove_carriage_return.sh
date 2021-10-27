#!/bin/sh
#  fixcr.sh
#
USAGE=" example: fixcr microslop.txt "
#
#
# script removes carriage return peculiar to Microsoft files.
#
#   (useful if you've ftp'd from a pc using binary mode, or are
#    moving files across a samba mount.  
#     microsoft adds extra characters, this script removes them.)
#
# Date: March 8, 2002
#  authors: doug matthews, john meister and bronson yi
#
# tr removes the "extra" carriage return, a temporary file
#    is created in current directory, if needed move file to
#    /tmp and execute there. 
#

FILENAME=$1

if  file $1 | grep ascii  > /dev/null 2>&1

then
	echo "file is ascii, editing..."
echo " "
	mv $FILENAME $FILENAME.tmp
	tr -d '\015' < $FILENAME.tmp >$FILENAME
	rm $FILENAME.tmp

else

	echo " "
	echo "not an ascii file NOT edited!!!"
	 echo " "
fi

echo " "
echo "script complete"
