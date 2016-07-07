## 安装bcl2fastq

wget ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2.17.1.14.tar.zip

tar -zxvf bcl2fastq2-v2.17.1.14.tar.zip

cd bcl2fastq2

mkdir build; cd build

../src/configure --prefix=$HOME > build.txt.log 2>&1

tail -f build.txt.log

### 可能出现的问题

* CMake complains `Required header sys/stat.h not found`

  `sudo apt-get install libc6-dev-amd64`

* `no support for gzip compression`

  `sudo apt-get install zlib1g-dev`

* bcl2fastq also complains no libxml2 and libxslt, but it could build by itself. And the version installed with ubuntu is too new :(


sudo apt-get install gfortran doxygen graphviz

