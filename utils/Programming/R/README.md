
## .Renviron and .Rprofile

* .Renviron 

  刚启动的时候可能会碰到下面问题：

    '''
    During startup - Warning messages:
    1: Setting LC_COLLATE failed, using "C"
    2: Setting LC_TIME failed, using "C"
    3: Setting LC_MESSAGES failed, using "C"
    4: Setting LC_MONETARY failed, using "C"
    '''

  在.Renviron设置变量即可:

    '''
    > cat ~/.Renviron
    R_LIBS=~/.local/R/library
    PAGER=/usr/bin/less
    LANGUAGE=en_US.utf8
    LC_ALL=en_US.UTF-8
    '''

* .Rprofile

  设定CRAN和bioconductor的镜像:

    ''' 
    > cat ~/.Rprofile
    options(repos=c(CRAN = "http://mirrors.ustc.edu.cn/CRAN/"),
            BioC_mirror="http://mirrors.ustc.edu.cn/bioc/")
    '''

## 安装R和Rstudio
   
   可以使用brew 安装，也可以使用conda安装：

*  使用brew安装

    `> brew cask install rstudio` 会自动安装r和rstudio.app，并将rstudio.app放到/Applications下面。
    
*  使用conda安装
    
    `> conda install rstudio`也会自动安装r和rstudio.app，但是`rstudio.app`只是放到conda自己的目录下，而没有放在`/Applications`下面。
    
*  使用brew安装的rstudio，但是使用conda安装的R  
    
    主要是因为我发现brew安装的R安装软件包的时候和conda安装的一些东西有冲突，并且，conda安装软件更方便一些。不过之后我也有可能换回brew安装的R。
    
    '''
    export RSTUDIO_WHICH_R=$(which R)
    launchctl setenv RSTUDIO_WHICH_R $RSTUDIO_WHICH_R  
    '''

    之后据说要运行`osascript -e 'tell app "Dock" to quit'`使环境变量生效，我试了一次没有用。简单有效的方式是重启电脑:(
