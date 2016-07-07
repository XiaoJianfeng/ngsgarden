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
