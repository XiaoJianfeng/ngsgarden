
## 在Mac上安装gitbook

1. 安装node

    ```
    > brew install node
    ```

2. 安装gitbook-cli

    ```
    > npm install -g gitbook-cli
    ```

3. (optional) 假如上面一步遇到问题的话，可能是目录权限问题，需要修复目录权限

    ```
    > sudo chown -R $(whoami) $(brew --prefix)
    > npm install -g gitbook-cli
    ```

4. 安装calibre。calibre提供了工具`ebook-convert`，而gitbook需要这个工具来生成pdf文件。

    ```
    > brew install Caskroom/cask/calibre
    ==> brew cask install Caskroom/cask/calibre
    ==> Downloading https://download.calibre-ebook.com/2.57.1/calibre-2.57.1.dmg
    ######################################################################## 100.0%
    ==> Verifying checksum for Cask calibre
    ==> Symlinking App 'calibre.app' to '/Users/xiaojf/Applications/calibre.app'
    ==> Symlinking Binary 'calibre' to '/usr/local/bin/calibre'
    ==> Symlinking Binary 'calibre-complete' to '/usr/local/bin/calibre-complete'
    ==> Symlinking Binary 'calibre-customize' to '/usr/local/bin/calibre-customize'
    ==> Symlinking Binary 'calibre-debug' to '/usr/local/bin/calibre-debug'
    ==> Symlinking Binary 'calibre-parallel' to '/usr/local/bin/calibre-parallel'
    ==> Symlinking Binary 'calibre-server' to '/usr/local/bin/calibre-server'
    ==> Symlinking Binary 'calibre-smtp' to '/usr/local/bin/calibre-smtp'
    ==> Symlinking Binary 'calibredb' to '/usr/local/bin/calibredb'
    ==> Symlinking Binary 'ebook-convert' to '/usr/local/bin/ebook-convert'
    ==> Symlinking Binary 'ebook-device' to '/usr/local/bin/ebook-device'
    ==> Symlinking Binary 'ebook-edit' to '/usr/local/bin/ebook-edit'
    ==> Symlinking Binary 'ebook-meta' to '/usr/local/bin/ebook-meta'
    ==> Symlinking Binary 'ebook-polish' to '/usr/local/bin/ebook-polish'
    ==> Symlinking Binary 'ebook-viewer' to '/usr/local/bin/ebook-viewer'
    ==> Symlinking Binary 'fetch-ebook-metadata' to '/usr/local/bin/fetch-ebook-metadata'
    ==> Symlinking Binary 'lrf2lrs' to '/usr/local/bin/lrf2lrs'
    ==> Symlinking Binary 'lrfviewer' to '/usr/local/bin/lrfviewer'
    ==> Symlinking Binary 'lrs2lrf' to '/usr/local/bin/lrs2lrf'
    ==> Symlinking Binary 'markdown-calibre' to '/usr/local/bin/markdown-calibre'
    ==> Symlinking Binary 'web2disk' to '/usr/local/bin/web2disk'
    🍺  calibre staged at '/opt/homebrew-cask/Caskroom/calibre/2.57.1' (3887 files, 205M)
    ```

5. 更新

    `> npm update -g`

## gitbook 建立新项目

    ```
    $ mkdir ngsgarden
    $ cd ngsgarden
    $ gitbook init
    $ vim .gitignore # 将"_book/", .DS_Store, book.pdf, node_modules/ 和其他一些不必要的文件假如忽略列表
    $ # 然后进行编辑并commit到本地。
    $ gitbook build   # 首先删除_book/下的所有文件，然后重新将产生的book的webpage存放与该目录下。
    $ git add .
    $ git commit -m "initial commit" 
    ```



## gitbook的代码和输出的书都托管在github上

1. github上建立该项目的代码库 `https://github.com/XiaoJianfeng/ngsgarden.git`

2. 将代码库提交到github

    ```
    $ cd ngsgarden
    $ git remote add origin https://github.com/XiaoJianfeng/ngsgarden.git
    $ git push origin master
    ```

3. 建立gh-pages这个分支。

    ```
    $ git checkout -b gh-pages  # 建立分支gh-pages
    $ git push origin gh-pages  # 提交更改到远程
    $ git checkout master       # 恢复当前目录为master分支
    ```

4. 为gh-pages建立单独的文件夹，并将`gitbook build`生成的文件夹`_book/`复制过去。

    因为`gitbook build`命令会先删除`_book/`目录下的所有文件，假如用`_book/`做`gh-pages`的目录的话，里面的`.git`文件夹会在这一步被删掉，所以只能另在外建立`gh-pages`的文件夹，每次运行`gitbook build`后将所生成的文件复制过去。

    ```
    $ cd ..  # 离开master分支所在的文件夹
    $ git clone -b gh-pages https://github.com/XiaoJianfeng/ngsgarden.git ngsgarden_book
    $ cd ngsgarden_book
    $ cp -r ../ngsgarden/_book/* .   #每次运行`gitbook build`后将所生成的文件复制过去。
    $ git add .
    $ git commit -m "[commit message]"
    $ git push origin gh-pages
    ```

    然后就可以在https://xiaojianfeng.github.io/ngsgarden/看到ngsgarden的webpage了。

    以后每次在`master`分支的文件夹进行编辑，并运行`gitbook build`，将生成的`_book/`复制到`gh-pages`所在的文件夹，然后提交到远程。
