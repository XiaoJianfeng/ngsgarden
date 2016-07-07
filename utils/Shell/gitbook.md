
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
