README

What is this?
	autoback a simple script to regularly backup your files. Just set it and forget it...sort of.

What do I need in order to use this?
	1. The latest autoback script.
	2. A dedicated partition for storing files.
	3. Cygwin with rsync (if running Windows)
	4. RsyncX if running on Mac. WARNING: Not tested on Mac!

	Refer to DOC/QuickStart.txt for basic instructions.

Why do I need this?
	Because backups don't happen. We're lazy and need something semi automated.

How do I use it?
	There's a QuickStart available in DOC. The script itself is also commented.

What's missing from this particular version?
	There's no cleanup. You'll want to periodically check your STORE for remaining space and delete the oldest backups as necessary. In the future, on each run, it will check for space and do this for you, maintaining a certain amount of free space.

This Linux crap looks dangerous!
	Rsync is only reading from your system and writing to your dedicated backup partition. It will not change your files on your system since it is only a one-way operation.

