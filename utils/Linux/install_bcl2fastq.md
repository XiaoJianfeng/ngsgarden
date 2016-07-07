## 安装bcl2fastq

```
# wget ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2.17.1.14.tar.zip
# 
# tar -zxvf bcl2fastq2-v2.17.1.14.tar.zip
# 
# cd bcl2fastq2
# 
# mkdir build; cd build
# 
# ../src/configure --prefix=$HOME > build.txt.log 2>&1
# 
# tail -f build.txt.log
# 
# ### 可能出现的问题
# 
# * CMake complains `Required header sys/stat.h not found`
# 
#   `sudo apt-get install libc6-dev-amd64`
# 
# * `no support for gzip compression`
# 
#   `sudo apt-get install zlib1g-dev`
# 
# * bcl2fastq also complains no libxml2 and libxslt, but it could build by itself. And the version installed with ubuntu is too new :(
# 
# 
# sudo apt-get install gfortran doxygen graphviz
```

* it is not easy to install the tarball. instead, you can install the rpm:

  1. wget ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2.17.1.14-Linux-x86_64.zip

  2. unzip bcl2fastq2-v2.17.1.14-Linux-x86_64.zip

  3. sudo alien -i bcl2fastq2-v2.17.1.14-Linux-x86_64.rpm

  4. bcl2fastq --runfolder-dir /home/rawdata/nextseq/160630_TPNB500112_0001_AHWLHYBGXX --output-dir 160630_TPNB500112_0001_AHWLHYBGXX_fastq > 160630_TPNB500112_0001_AHWLHYBGXX.bcl2fastq.log 2>&1 &

