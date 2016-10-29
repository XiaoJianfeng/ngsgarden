
## 安装homebrew 

1. go to http://brew.sh, follow the instruction, which is as simple as:

	```
	usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	```

2. 假如碰到错误：```curl: (35) Server aborted the SSL handshake```, 是网络的问题，需要先卸载homebrew

	```
	usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
	```

    然后重新安装homebrew:

	```
	usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	```

## 使用镜像 -- 使用USTC或者清华的镜像

* USTC:

```
# setup brew
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

# setup brew-core
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

brew update -v 

# setup binary mirror
echo "export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles" >> ~/.zshrc
source ~/.zshrc

[1] https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git
[2] https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-core.git
[3] https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-bottles
```

* Tsinghua - not tested

```
cd "$(brew --repo)"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

# 使用homebrew-science或者homebrew-python

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-science"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-science.git

cd "$(brew --repo)/usr/local/Library/Taps/homebrew/homebrew-python"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-python.git

brew update -v

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
source ~/.zshrc
```

## 安装homebrew的Cask扩展

```brew tap caskroom/cask```
	
## install iterm2

安装Cask扩增之后, 才能用brew安装iterm2

```$ brew cask install iterm2```

## 安装oh-my-zsh

1. 安装

	```sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"```

2. 编辑~/.zshrc

	```
	#plugins=(git git-extras tmux docker common-aliases osx autojump)
	plugins=(git git-extras tmux osx autojump)
	```
	
	```
	export PS1="%n@%m[%l] %~> "
	
	if [ ! -z $STY ]
	then
	    export PS1="(screen)${PS1}"
	fi
	if [ ! -z $TMUX ]
	then
	    export PS1="(tmux)${PS1}"
	fi
	```

## install perl environment on Mac

1. install perlbrew

    ```
    # override the default installation directory ($HOME/perl5) in .zshrc
    export PERLBREW_ROOT=$HOME/.local/perl5
    export PERLBREW_CPAN_MIRROR=http://mirrors.ustc.edu.cn/CPAN/
    
    > curl -L http://xrl.us/perlbrewinstall | bash
    
    > echo "source ~/.local/perl5/perlbrew/etc/bashrc" >> ~/.zshrc
    ```

2. install perl and cpanm

    ```
    > perlbrew available
    > perlbrew install stable
    > perlbrew list
    > perlbrew switch perl-5.22.1
    > perlbrew install install-cpanm
    
    > alias cpanm='cpanm --from http://mirrors.ustc.edu.cn/CPAN/ '
    ```

3. install perl packages

    ```
    > cpanm Bio::SeqIO
    ```
