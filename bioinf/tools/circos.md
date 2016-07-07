### 在ubuntu上安装circos  - install circos on ubuntu

手动安装最主要的问题是，circos所依赖的一些perl的包在操作系统上不是默认安装的，只需要把这些依赖的包安装好即可。

1. install cpanm and config cpan to use CPAN mirros located in China

2. download circos and unzip it to appropriate location

3. install required perl libraries with cpanm

    ```
    $ for m in $(./circos -modules | grep missing | awk '{print $2}' | cut -f 2)
    > do
    > echo $m
    > cpanm --mirror http://mirrors.ustc.edu.cn/CPAN/ $m
    > done
    ```

4. you may need to install libgd with `sudo aptitude install libgd-perl`

5. edit first line of `circos/bin/gddiag`

    ``` "#!/bin/env perl" -->  "#!/usr/bin/env perl" ```

6. then test if the installation works

    ```
    $ cd circos/example
    $ ./run
    ```
    
    
