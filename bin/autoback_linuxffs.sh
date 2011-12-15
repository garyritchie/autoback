#!/bin/sh

## Get the latest version of this script and example configuration files from:
	## git clone https://chocolategary@code.google.com/p/autoback/   

## autoback is a TimeMachine-like backup script. It expects the following folder structure on a dedicated backup drive or partition:
	# T:/autoback				<-- Everything tidily kept in one directory.
	# T:/autoback/bin			<-- This is where this script resides
	# T:/autoback/conf			<-- Include and exclude configuration files
	# T:/autoback/store   		<-- This is where timestamped backup directories are kept

## REQUIREMENTS:
	## Above Folder structure
	## Cygwin with rsync (if running Windows)
	## RsyncX if running on Mac. WARNING: Not tested on Mac!

## SETUP for WINDOWS:
	## Point Control Panel --> Scheduled Tasks to T:/autoback/bin/autoback_starter.bat

## IF you are on a multi-boot machine: You have to set aliases in cygwin to match linux directories. In a Cygwin bash terminal window type:
	## $ mkdir /media
	## $ ln -s /cygdrive/g /media/Production
	
	## This will create a directory at the root of C: called /media and the second command creates a link enabling this script to work for both Win and Linux environments.

## - - - - - SET YOUR OPTIONS 1-4 BELOW. Comment/uncomment as necessary...
## 1 - - - - Backup storage location - - - - 
#AUTOBACK=/media/FNTM250TM/autoback 		## MULTI-BOOT cxmacwin01 (cygwin alias set)
#AUTOBACK=/cygdrive/t/autoback		## cxmacwin01 - Windows only. Set dedicated backup drive to T:.
AUTOBACK=/mnt/autoback/autoback		## @ home
STORE=$AUTOBACK/store

## 2 - - - - ONE source can be listed here - - - -
#SOURCE=/media/Production/				## MULTI-BOOT (cygwin alias set)
#SOURCE=/cygdrive/g/					## Windows only. Production drive G: must be set.
SOURCE=/					## @ full file system access

## 3 - - - - Include what from SOURCE above? - - - -
INCLUDES=$AUTOBACK/conf/backup_includeffs.conf	## /CX_PRODUCTION and /CX_PROJECTS (do not change.)

## 4 - - - - got anything to leave out? - - - - - 
EXCLUDES=$AUTOBACK/conf/backup_excludeffs.conf	## Edit this file. Not everything needs to be backed up, right?   

echo Source: $SOURCE
echo Store: $STORE
echo Includes: $INCLUDES
echo Excludes: $EXCLUDES
sleep 3

## DO NOT EDIT BELOW THIS LINE - - - - - - - - - - - - - - - - --
## ------------- system commands used by this script --------------------
#DATE=/usr/bin/date;
DATE=/bin/date;
#RM=/usr/bin/rm;
RM=/bin/rm;
#LN=/usr/bin/ln;
LN=/bin/ln;
RSYNC=/usr/bin/rsync;

date=`$DATE "+%Y%m%d-%H%M%S"`

## TODO: LINUX: Test --modify-window. When rsyncing in cygwin after a linux rsync the entire drectory is synced. Subsequent backups are properly linked.

#mkdir $STORE/$date
#touch $STORE/$date/autoback.log

## Rsync options edited for linux. -rltDhv used because we're backing up to an NTFS partition (no user/group)...
$RSYNC -ahv --delete-after --delete-excluded --stats --progress \
	--exclude-from="$EXCLUDES" \
	--include-from="$INCLUDES" \
	--link-dest=$STORE/recent \
	$SOURCE $STORE/$date \
	--log-file=$STORE/$date"_autoback.log"

$RM -r $STORE/RECENT

## NOTE: links do not work on vfat formatted partitions! Also not tested on network shares.
$LN -s $date $STORE/recent
