## 增加用户

   * 增加新用户

   `$ sudo adduser UserName` or `$ sudo useradd UserName`

   * 将该用户添加至sudo用户组，这样该用户就可以使用sudo

   `$ sudo adduser UserName sudo`
 
   * 增加用户组bioinf，并将新用户添加至该组

   `$ sudo addgrp bioinf`

   `$ sudo adduser UserName bioinf`

## ssh

   * 生成ssh的密匙

     `$ ssh-keygen`

   * 将本地的公开密匙(~/.ssh/id_rsa.pub)复制到远程服务器账号的认证文件(~/.ssh/authorized_keys)里

     `$ cat ~/.ssh/id_rsa.pub | ssh data@IP.XXX.XXX.XXX "mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"`

## sudo 配置 

   /etc/sudoers文件不能直接编辑，需要使用`sudo visudo`命令去编辑:

   `sudo visudo `

   增加针对用户UserName的行，指定可以用sudo运行所有命令，但是只有运行aptitude和shutdown命令可以免密码。

   `UserName ALL=(ALL) NOPASSWD:/usr/bin/aptitude,/sbin/shutdown`

   或者增加针对用户UserName的行，指定可以用sudo运行所有命令，且运行所有命令免密码。

   `UserName ALL=(ALL) NOPASSWD:ALL`


## samba

   * 确定samba命令安装

     `sudo apt install samba`

   * 建立文件夹、用户组和用户。其中用户无需设定登陆shell，因为该用户不用登录。另外，用户的密码要用smbpaswd来修改。

     ```
     sudo mkdir -p /home/rawdata/nextseq             # 建立要共享的目录
     sudo addgroup rawdata                           # 增加用户组以利于管理
     sudo useradd nextseq -g rawdata -d /home/rawdata/nextseq  # 增加用户并指定用户组和主目录
     sudo chgrp -R rawdata /home/rawdata                       # 将rawdata目录指定为rawdata用户组所有
     sudo chown -R nextseq /home/rawdata/nextseq               # 将用户主目录指定为该用户所有
     sudo touch /etc/smbpasswd                                 # 建立samba的用户密码文件
     sudo smbpasswd nextseq                                    # 使用smbpasswd修改用户的密码
     ```

   * 修改/etc/samba/smb.conf

     ```
     [global]

        workgroup = WORKGROUP   # leave it unmodified
        security  = user        # added by xiaojf

     [nextseq]
         comment = Sequencing Data SAMBA File Server
         path = /home/rawdata/nextseq
         browsable = yes
         guest ok = no
         read only = no
         valid users = nextseq
         create mask = 0755
     ```

   * 重启samba服务

     `sudo systemctl restart smbd.service nmbd.service`

   * 参考资料

     1. https://www.howtoforge.com/tutorial/samba-server-ubuntu-16-04/#-secured-samba-server
     2. https://help.ubuntu.com/lts/serverguide/samba-fileserver.html
     3. https://help.ubuntu.com/lts/serverguide/samba-fileprint-security.html

## conda

   conda最初是用来管理python程序库的一个程序(刚开始的时候和pip+venv比较类似），由Continuum Analytics开发，但是由于比较好用，后来被用来管理python之外的程序，包括R、Perl和其它通用程序，例如[bioconda](https://bioconda.github.io)，是一个生物信息学社区开发的一个项目，使用conda，通过一个bioconda的channel，来管理生物信息学相关的程序。

   * 下载miniconda (anconda太大了）并安装
 
   ```
   # http://conda.pydata.org/miniconda.html
   wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
   . Miniconda2-latest-Linux-x86_64.sh
 
   # 安装的时候，选择miniconda的安装路径。
 
   # 按照提示，接受由conda将其存放可执行文件的bin目录加进环境变量PATH里面。
   ```
   
   * 使用清华提供的anaconda的镜像，实际上是增加一个channel。官方的镜像太慢了，bioconda因为清华其镜像，所以还是比较慢。
 
   ```
   conda config --add channels 'https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/' 
   conda config --set show_channel_urls yes 
   ```
   
   * 增加R和biocond的channel
   ```
   conda config --add channels r 
   conda config --add channels bioconda 
   ```
   
   * 通过[anaconda.org](https://anaconda.org) 和 [bioconda](https://bioconda.github.io)查找可用的程序。
   
   * 使用conda命令来安装
 
   `conda install bwa samtools bedtools bcftools`

   `conda install blast blat bowtie2 circos cutadapt delly fastqc fastx_toolkit gemini htslib htseq jellyfish kallisto khmer last multiqc multiqc-bcbio picard pindel prinseq pyvcf seqtk snpeff spades svviz tabulate tophat trimadap trimmomatic varscan vcftools vt `
   
   * 创建、使用和删除环境
 
     * 创建环境
 
       `conda create --name illumina boost=1.57.0 gcc=4.8.5 libgcc=4.8.5 cmake=2.8.9 zlib # illumina是所创建的环境名称`
 
     * 使用环境
 
       `source activate illumina`
 
       `source deactivate`
 
     * list环境列表
 
       `conda info --envs` or `conda env list`
 
     * 删除环境
 
       `conda remove --name illumina --all`


## NFS

   * 为什么要使用NFS？
 
   NFS是Network FileSystem。当在不同服务器之间要共享文件系统时，NFS是一个比较好的选择（还有其它系统可以选择），历史悠久，可靠性比较高，性能也不错。
 
   * NFS和SAMBA是否可以同时共享同一个文件夹
 
   我的服务器架构是这样的，测序仪(操作系统win7)将测序数据实时写入到一台专用服务器（Seq），Seq安装Ubuntu 16.04，为了能够让测序仪的win7能够读写服务器Seq的文件系统，将Seq的一个目录采用SAMBA共享；同时，数据分析服务器（Bioinf1，Bioinf2）又需要直接从Seq上读原始的BCL文件，转化为fastq文件，写入自己的文件系统：这样就要求，Seq的存储原始测序数据的文件夹在通过SAMBA共享给win7的同时，也要共享给Linux服务器Bioinf1和Bioinf2。
 
   NFS是可以将Seq上面的文件夹共享出来的，但是随之而来的一个问题是：NFS和SAMBA是否可以同时共享同一个文件夹?
 
   Google了一下，有的说是可以的，有的说假如SAMBA和NFS同时写同一个文件可能会出问题。考虑到我的服务器上，SMABA共享是可读可写，NFS共享只读就可以，所以感觉不会有问题。

