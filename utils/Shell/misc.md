## how to re-attach a lftp process

lftp很好的一个功能是退出之后，正在运行的任务会自动提交到后台继续运行。

但是有时候想重新连接这些任务，应该怎么办呢？

lftp提供了一个很好的命令`attach`:

1. 首先用ps查到要连接的任务的pid;

2. 然后打开lftp，运行`attach The_PID`。搞定。
