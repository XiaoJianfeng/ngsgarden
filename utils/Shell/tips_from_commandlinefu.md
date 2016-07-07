## less +F somelogfile

   Make 'less' behave like 'tail -f'.

   Using +F will put less in follow mode. This works similar to 'tail -f'. To stop scrolling, use the interrupt. Then you'll get the normal benefits of less (scroll, etc.).

   Pressing SHIFT-F will resume the 'tailling'.

## man hier

   解释系统的文件结构 (Show File System Hierarchy)

   Curious about differences between /bin, /usr/bin, and /usr/local/bin? What should be in the /sbin dir? Try this command to find out.

   Tested against Red Hat & OS X

## rm -f !(survivior.txt)

   Remove all but one specific file

## vim scp://username@host//path/to/somefile

   Edit a file on a remote host using vim

## pv access.log | gzip > access.log.gz

   Monitor progress of a command

   Pipe viewer is a terminal-based tool for monitoring the progress of data through a pipeline. It can be inserted into any normal pipeline between two processes to give a visual indication of how quickly data is passing through, how long it has taken, how near to completion it is, and an estimate of how long it will be until completion. Source: http://www.catonmat.net/blog/unix-utilities-pipe-viewer/

## fuser -k filename

   Kills a process that is locking a file.

   Useful when you\'re trying to unmount a volume and other sticky situations where a rogue process is annoying the hell out of you.
