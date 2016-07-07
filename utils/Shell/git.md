
## 从现有仓库克隆

```
$ git clone git://github.com/schacon/grit.git
$ git clone git://github.com/schacon/grit.git mygrit
```

## .gitignore文件

```
$ cat ~/.gitignore
*~
```

## 撤消操作

* 修改最后一次提交

    ``` $ git commit --amend ```

  如果刚才提交时忘了暂存某些修改，可以先补上暂存操作，然后再运行 `git commit --amend` 提交：

    ```
    $ git commit -m 'initial commit'  
    $ git add forgotten_file  
    $ git commit --amend  
    ```

* 取消已经暂存的文件 - 其实，`git status` 的命令输出已经告诉了我们该怎么做

    ```
    $ git add .  
    $ git status  
    On branch master  
    Changes to be committed:  
    (use "git reset HEAD <file>..." to unstage)  
  
         modified:   README.txt  
         modified:   benchmarks.rb    
    $ git reset HEAD benchmarks.rb  
    Unstaged changes after reset:   
    M       benchmarks.rb   
    ```

* 取消对文件的修改 - `git status` 同样提示了具体的撤消方法

    ```
     Changes not staged for commit:  
     (use "git add <file>..." to update what will be committed)   
     (use "git checkout -- <file>..." to discard changes in working directory)  

             modified:   benchmarks.rb  

    $ git checkout -- benchmarks.rb  
    $ git status  
    On branch master  
    Changes to be committed:  
    (use "git reset HEAD <file>..." to unstage)  
  
        modified:   README.txt   
     ```

     任何已经提交到 Git 的都可以被恢复。即便在已经删除的分支中的提交，或者用 --amend 重新改写的提交，都可以被恢复（关于数据恢复的内容见第九章）。所以，你可能失去的数据，仅限于没有提交过的，对 Git 来说它们就像从未存在过一样。

## 远程仓库的使用

* 查看当前的远程库

    ```
    $ git remote  
    $ git remote -v  
    ```

* 添加远程仓库 - `git remote add [shortname] [url]`

    ```
    $ git remote  
    origin  
    $ git remote add pb git://github.com/paulboone/ticgit.git  
    $ git remote -v  
    origin  git://github.com/schacon/ticgit.git  
    pb  git://github.com/paulboone/ticgit.git  
    ```

  现在可以用字符串 pb 指代对应的仓库地址了。比如说，要抓取所有 Paul 有的，但本地仓库没有的信息，可以运行 `git fetch pb`：

    ```
    $ git fetch pb  
    remote: Counting objects: 58, done.  
    remote: Compressing objects: 100% (41/41), done.  
    remote: Total 44 (delta 24), reused 1 (delta 0)  
    Unpacking objects: 100% (44/44), done.  
    From git://github.com/paulboone/ticgit  
     * [new branch]      master     -> pb/master  
     * [new branch]      ticgit     -> pb/ticgit  
     ```

* 从远程仓库抓取数据

    ```
    $ git fetch [remote-name]
    ```

  如果是克隆了一个仓库，此命令会自动将远程仓库归于 origin 名下。所以，git fetch origin 会抓取从你上次克隆以来别人上传到此远程仓库中的所有更新（或是上次 fetch 以来别人提交的更新）。有一点很重要，需要记住，fetch 命令只是将远端的数据拉到本地仓库，并不自动合并到当前工作分支，只有当你确实准备好了，才能手工合并。

  如果设置了某个分支用于跟踪某个远端仓库的分支（参见下节及第三章的内容），可以使用 git pull 命令自动抓取数据下来，然后将远端分支自动合并到本地仓库中当前分支。在日常工作中我们经常这么用，既快且好。实际上，默认情况下 git clone 命令本质上就是自动创建了本地的 master 分支用于跟踪远程仓库中的 master 分支（假设远程仓库确实有 master 分支）。所以一般我们运行 git pull，目的都是要从原始克隆的远端仓库中抓取数据后，合并到工作目录中的当前分支。

* 推送数据到远程仓库 - `git push [remote-name] [branch-name]`

  如果要把本地的 master 分支推送到 origin 服务器上（再次说明下，克隆操作会自动使用默认的 master 和 origin 名字），可以运行下面的命令：

    ```
    $ git push origin master  
    ```

  只有在所克隆的服务器上有写权限，或者同一时刻没有其他人在推数据，这条命令才会如期完成任务。如果在你推数据前，已经有其他人推送了若干更新，那你的推送操作就会被驳回。你必须先把他们的更新抓取到本地，合并到自己的项目中，然后才可以再次推送

* 查看远程仓库信息 - `git remote show [remote-name]`

    ```
    $ git remote show origin  
    * remote origin  
      URL: git://github.com/schacon/ticgit.git  
      Remote branch merged with 'git pull' while on branch master  
       master  
      Tracked remote branches  
       master  
       ticgit  
    ```


* 远程仓库的删除和重命名 - `git remote rename`

  比如想把 pb 改成 paul，可以这么运行：

    ```
    $ git remote rename pb paul    
    $ git remote    
    origin    
    paul  
    ```

  注意，对远程仓库的重命名，也会使对应的分支名称发生变化，原来的 pb/master 分支现在成了 paul/master。
      
  碰到远端仓库服务器迁移，或者原来的克隆镜像不再使用，又或者某个参与者不再贡献代码，那么需要移除对应的远端仓库，可以运行 `git remote rm` 命令：
      
    ```
    $ git remote rm paul  
    $ git remote  
    origin  
    ```
