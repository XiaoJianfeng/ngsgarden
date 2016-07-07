## why ubuntu, and why 16.04 

主要就是debian还是ubuntu了。

十年以前，我是选择debian的，简单，快；ubuntu有些笨重。

十年之后，我选择ubuntu了，持续的商业化的支持让ubuntu更胜一筹，例如阿里云和华为云都支持Ubuntu而不支持debian。

至于为什么不考虑其它：

   * RedHat太难用了，而且加入了很多自己的东西，与其它的linux版本都很不一样，主流的开源世界的bioinf世界很多软件是基于debian或者ubuntu开发的，基于RedHat的CentOS所以也不考虑了

   * Suse与RedHat类似，而且二者装软件都太麻烦了。 但是大型的服务用这两者的还是更多，最主要因为出了问题有地方买服务。


另外，据说在IT人的世界，有一条鄙视链：

    用Plan 9的鄙视用Mac的，
    用Mac的鄙视用FreeBSD的，
    用FreeBSD的鄙视用Debian的，
    用Debian的鄙视用Ubuntu的，
    用Ubuntu的鄙视用CentOS的，
    用CentOS的鄙视用RedHat的，
    用RedHat的鄙视用用Windows的，
    最后，
    公司用Windows的前台鄙视所有这帮傻人。


## 文件系统的选择

文件系统最重要的是稳定性，然后是IO性能。

XFS是SGI当初在IRIS操作系统上设计的文件系统，纯正的Unix血统，稳定性极强，性能也很好。说起SGI，它的共享内存的服务器实在好用，任何一个CPU都可以使用所有的内存，不像现在的那些cluster，一个节点上的CPU只能使用该节点自己的内存，SGI的IRIS的操作系统也异常稳定，就是老得掉牙，读研究生期间一直在用，让人又爱又恨，装个GCC都装不上，编译很多开源软件都会有或多或少的问题。

XFS后来被移植到Linux上，稳定性和IO性能居说依然强劲。

ZFS更猛，号称最后一个文件系统（以最后一个字母－－“Z”打头），自从在Solaris上横空出世之后，一直是众多操作系统垂涎的对象。因为Solaris和BSD系统的渊源，所以开源后很快被移植到FreeBSD上。但是由于许可证的问题，一只不能彻底移植到Linux上，这次Ubuntu 16.04号成原生支持ZFS，不过也有人认为这样是不合法的。不管怎样，ZFS在Linux上的支持还不是很完美和稳定，所以暂时不考虑ZFS（倒是可以考虑在自己的Linux PC上用ZFS）。以后等ZFS在Linux真正成熟和稳定了，说不定ZFS可以一统天下。

但是GRUB对NFS的支持不好，所以/boot不能用XFS，建议继续用EXT4，其它分区用XFS。

## 交换分区(SWAP)

在计算机内存还是以MB为单位的年代，SWAP被推荐设置为内存的两倍，比如内存512M，SWAP就设置为1024M（1G）。但是如今服务器内存相对磁盘，并没有小太多，比如我的计算节点有512G内存，此时假如用1T的SWAP太浪费，而且，内存这么大的情况下，SWAP不是一定需要的。

所以我最重的设置是：所有主机都设置了64G的交换分区（SWAP）。

## 磁盘冗余阵列（RAID）的配置

RAID通常有RAID0, RAID1, RAID10, RAID5, RAID6等级别可选。在磁盘设置冗余之外，还可以设置热备盘－－一顾名思义，一块热备、随时可以替换出错硬盘的硬盘。在实际应用中，应该综合考虑IO吞吐量、可用磁盘空间、可靠性。

我们的服务器是这样设置的：

```
* 计算节点1和计算节点2: 两块系统自带硬盘－RAID1, EXT4；磁盘阵列：RAID6, XFS。
* 备份服务器：两块系统自带硬盘－RAID1, EXT4；磁盘阵列：RAID5, XFS。
* 测序仪直连存储：两块系统自带硬盘－RAID1, EXT4；磁盘阵列：RAID6 + 1 hotspare, XFS。
```

另外，热备盘可以选择是全局热备还是针对局部热备，我选择的是局部热备，因为系统自带硬盘和磁盘阵列的硬盘都不一样大，想全局热备也不行。

## 安装文件

页面 `http://releases.ubuntu.com/16.04/`

服务器版64位：`http://releases.ubuntu.com/16.04/ubuntu-16.04-server-amd64.iso`

## XFS and NFS

1. 挂载XFS分区时，记得添加inode64参数。否则会默认使用inode32来挂载。 
2. 本地目录通过NFS export时，记得添加fsid=XX参数。

https://help.ubuntu.com/community/NFSv4Howto

```
http://xfs.org/index.php/XFS_FAQ

Q: Why doesn't NFS-exporting subdirectories of inode64-mounted filesystem work?

The default fsid type encodes only 32-bit of the inode number for subdirectory exports. However, exporting the root of the filesystem works, or using one of the non-default fsid types (fsid=uuid in /etc/exports with recent nfs-utils) should work as well. (Thanks, Christoph!)

Q: What is the inode64 mount option for?

By default, with 32bit inodes, XFS places inodes only in the first 1TB of a disk. If you have a disk with 100TB, all inodes will be stuck in the first TB. This can lead to strange things like "disk full" when you still have plenty space free, but there's no more place in the first TB to create a new inode. Also, performance sucks.

To come around this, use the inode64 mount options for filesystems >1TB. Inodes will then be placed in the location where their data is, minimizing disk seeks.

Beware that some old programs might have problems reading 64bit inodes, especially over NFS. Your editor used inode64 for over a year with recent (openSUSE 11.1 and higher) distributions using NFS and Samba without any corruptions, so that might be a recent enough distro.

Q: Can I just try the inode64 option to see if it helps me?

Starting from kernel 2.6.35, you can try and then switch back. Older kernels have a bug leading to strange problems if you mount without inode64 again. For example, you can't access files & dirs that have been created with an inode >32bit anymore.
```

## 安装过程

将刻好的安装镜像放入光驱，一路按照提示进行即可。

我安装操作系统的时候，网线和交换机还没有准备好，所以安装的时候没有配置网络，安装完再配置也非常简单。

其中有一步是选择安装的组件，这一步根据实际情况，我选择了`OpenSSH` 和 `SAMBA`。

## bug - 无法安装 busybox-initramfs

这个是一个bug，假如开始安装的时候选择了中文，就会有这个问题，没有深究原因，但是安装过程中全部使用英文，是可以避免的。

```
language: English; 
locale: en_US.UTF-8
country: China
```

## 网络配置基础知识

  需要配置的有几个方面，IP地址、网关（gateway）、子网掩码（netmask）、域名解析服务器（DNS）、主机名（hostname）。

* 查看可用的网卡

  一般的电脑网卡名称默认是eth0, eth1, eth2, ...,但是我们的服务器使用的是eno1, eno2, eno3, eno4，每个服务器有四个网卡。

  ```ifconfig -a | grep eth```
  ```ifconfig -a | grep eno```

* 查看所有的网络接口

  ```sudo lshw -class network```
  
* 使用ifconfig命令临时设定IP地址
  
  ```sudo ifconfig eth0 10.0.0.100 netmask 255.255.255.0```
  
* 确认IP地址
  
  ```ifconfig eth0 ```
  
* 默认网关
  
  ```
  sudo route add default gw 10.0.0.1 eth0
  route -n
  ```
  
* 临时设定DNS
  
  临时设定DNS，可以在`/etc/resolv.conf`中设置，但这只是临时起作用，计算机重启之后将会被覆盖。下面是一个示例：
  
  ```
  nameserver 8.8.8.8
  nameserver 8.8.4.4
  ```
  
* 去除所做更改，恢复原样
  
  ``` ip addr flush eth0 ```
  
  但是命令`ip`并不清除`/etc/resolv.conf`中的内容，所以需要手动修改该文件，或者重启计算机。`/etc/resolv.conf`实际上是`/run.resolvconf/resolv.conf`的一个符号链接，每次计算机重启的时候被重新覆盖。

## 网络配置实际操作

实际配置很简单，只需要修改一个文件，`/etc/network/interfaces`。可以把DNS服务器信息写在这个文件里面，这样就无需配置`/etc/resolv.conf`或者其它文件。

1. 首先做一个备份

    ```
    cd /etc/network
    sudo cp interfaces interfaces.bak
    ```

2. 编辑文件

    编辑后的文件如下:
    
    ```
    source /etc/network/interfaces.d/*
    # the line above is just copied from the original file
    
    auto lo eno1
    
    iface lo inet loopback
    
    iface eno1 inet static
        address 192.168.XXX.YYY
        netmask 255.255.255.0
        gateway 192.168.XXX.1
        dns-nameservers 192.168.ZZZ.AAA 192.168.ZZZ.BBB
    ```
    
    配置文件里，还可以针对不同的域名选择不同的DNS服务器，但是我这里的情况是，针对所有的域名都使用同样一组DNS服务器。

3. 启动网卡

    ```
    sudo ifup eno1
    ping www.bing.com
    ```

## 配置apt的镜像

在安装的时候，只要选择了country是china，那么apt的sources.list里面已经自动使用了中国的镜像（大概是cn.archives.ubuntu.com/ubuntu/)，但是国内其它镜像可能会更快，例如：

```
* 阿里	- http://mirrors.aliyun.com/ubuntu/
* 163	- http://mirrors.163.com/ubuntu/
* 清华
* 中科大
```

这里我选择了aliyun的镜像。打开`/etc/apt/sources.list`文件，将其中的`cn.archives.ubuntu.com`替换为`mirrors.aliyun.com/ubuntu/`即可。

## 至此，ubuntu 16.04的基本安装结束。
