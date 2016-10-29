## align的时候使用哪个genome

### GRCh37 还是 GRCh38

GRCh37 == hg19，GRCh38 ＝＝ hg38

理论上来讲，GRCh38因为是最新的人类基因组的参考组装，所以更接近人类真正的基因组。但是由于历史原因，之前很多的数据库对老版本的GRCh37支持的比较好。 dbSNP和ClinVar已经同时支持 GRCh37和38，但是1k genomes还是对GRCh37支持更好一些，主要是1k genomes的很多vcf需要针对GRCh38重新做alignment和variant calling，太费事了。

我看到有公司是使用GRCh38的，并且声称效果更好。但是，目前，我们做计算，至少要能够支持GRCh37.

### 1k genomes 使用的hs37d5 是什么

1k genomes项目组在做alignment的时候，使用的是hs37d5 （ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/phase2_reference_assembly_sequence）.

主要是因为在align的时候，有一些reads不能比对到参考基因组上，然后做align的软件就要非费尽心思来给这些reads找次优的位置，而这是非常费时的一步。经过研究发现，这些reads主要是来自于疱疹病毒和一些简单的重复片段，把这些序列加进参考基因组，可以省不少时间，因为一下子就可以找到reads的最优位置，不用费心去找次优位置。

下面是1k genomes的官方说明(ftp://ftp.1000genomes.ebi.ac.uk:/vol1/ftp/technical/reference/phase2_reference_assembly_sequence/README_human_reference_20110707):

```hs37d5.fa.gz    

Integrated reference sequence from the GRCh37 primary assembly (chromosomal plus unlocalized and unplaced contigs), the rCRS mitochondrial sequence (AC:NC_012920), Human herpesvirus 4 type 1 (AC:NC_007605) and the concatenated decoy sequences (hs37d5cs.fa.gz). This file is compressed by razip from the samtools package for random access.  Gzip may complain "decompression OK, trailing garbage ignored", but this does not affect the correctness of the decompressed file.
```

### 1k genomes使用饿GRCh38的参考基因组

ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome
