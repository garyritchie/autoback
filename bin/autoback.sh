#!/bin/sh

## Get the latest version of this script and example configuration files from:
	## http://code.google.com/p/autoback/

## autoback is a TimeMachine-like backup script. It expects the following folder structure on a dedicated backup drive or partition:
	# A:/autoback				<-- Everything tidily kept in one directory.
	# A:/autoback/bin			<-- This is where this script resides
	# A:/autoback/conf			<-- Include and exclude configuration files
	# A:/autoback/STORE		<-- This is where timestamped backup directories are kept

## REQUIREMENTS:
	## Above Folder structure
	## Cygwin with rsync (if running Windows)
	## RsyncX if running on Mac. WARNING: Not tested on Mac!

## SETUP for WINDOWS:
	## Point Control Panel --> Scheduled Tasks to A:/autoback/bin/autoback_starter.bat

## IF you are a multi-boot machine: You have to set aliases in cygwin to match linux directories. In a Cygwin bash terminal window type:
	## $ mkdir /media
	## $ ln -s /cygdrive/g /media/Production
	
	## This will create a directory at the root of C: called /media and the second command creates a link enabling this script to work for both Win and Linux environments.

## - - - - - SET YOUR OPTIONS 1-2 BELOW. Comment/uncomment as necessary...
## 1 - - - - Backup storage location - - - - 
#AUTOBACKTM=/media/FNTM250TM/AUTOBACKTM/STORE 		## MULTI-BOOT cxmacwin01 (cygwin alias set)
AUTOBACK=/cygdrive/a/autoback		 	## Windows only. Set dedicated backup drive to A:.
# AUTOBACKTM=/home/Gary/Desktop/test/AUTOBACKTM	## TEST @ home only!
STORE=$AUTOBACK/STORE

## 2 - - - - ONE source can be listed here - - - -
#SOURCE=/media/Production				## MULTI-BOOT (cygwin alias set)
SOURCE=/cygdrive/c/CLIENT/						## Windows only


## DO NOT EDIT BELOW THIS LINE - - - - - - - - - - - - - - - - --
## 3 - - - - Include what from SOURCE above? - - - -
INCLUDES=$AUTOBACK/conf/backup_include.conf

## 4 - - - - got anything to leave out? - - - - - 
EXCLUDES=$AUTOBACK/conf/backup_exclude.conf	## Edit this file. Not everything needs to be safeguarded.

echo Source: $SOURCE
echo Store: $STORE
echo Includes: $INCLUDES
echo Excludes: $EXCLUDES
/usr/bin/sleep 3


## ------------- system commands used by this script --------------------
DATE=/usr/bin/date;
RM=/usr/bin/rm;
LN=/usr/bin/ln;
RSYNC=/usr/bin/rsync;

date=`$DATE "+%Y%m%d-%H%M%S"`

$RSYNC -rltDHhv --delete-after --delete-excluded --stats --progress --modify-window=2 \
	--exclude-from="$EXCLUDES" \
	--include-from="$INCLUDES" \
	--link-dest=$STORE/RECENT \
	$SOURCE $STORE/$date \
	--log-file=$STORE/$date"_autoback.log"

$RM -r $STORE/RECENT

## NOTE: links do not work on vfat!
$LN -sfv $STORE/$date $STORE/RECENT
