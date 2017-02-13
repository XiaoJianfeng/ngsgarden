## igv 生成本地的.genome文件

igv的.genome文件其实是一个zip文件。

先看一下hg19.genome的内容：

```
> cp ~/igv/genomes/hg19.genome .
> unzip hg19.genome
Archive:  hg19.genome
inflating: cytoBand.txt
inflating: hg19_alias.tab
inflating: property.txt
inflating: refGene.txt
> cat property.txt
id=hg19
name=Human hg19
cytobandFile=cytoBand.txt
ordered=true
geneFile=refGene.txt
geneTrackName=RefSeq Genes
chrAliasFile=hg19_alias.tab
fasta=True
sequenceLocation=http://s3.amazonaws.com/igv.broadinstitute.org/genomes/seq/hg19/hg19.fasta
url=http://www.ncbi.nlm.nih.gov/gene?term=$$
```

可以看到，里面的cytoband文件，gene文件都是本地的，但是序列文件是在AWS上面的。而最近AWS的访问有问题，非常不稳定，所以igv也不能打开hg19.genome了。

让igv都使用本地的文件，只需要修改property.txt即可，修改property.txt如下：
```
id=hg19-local
name=Human hg19 local
cytobandFile=cytoBand.txt
ordered=true
geneFile=refGene.txt
geneTrackName=RefSeq Genes
chrAliasFile=hg19_alias.tab
fasta=True
sequenceLocation= /Users/xiaojf/data/genomes/hs37d5/hs37d5.fa
url=http://www.ncbi.nlm.nih.gov/gene?term=$$
```

其中sequenceLocation改成本地的基因组fasta文件。

然后重新打包成.genome文件即可:

```
> zip hg19_local.genome cytoBand.txt refGene.txt hg19_alias.tab property.txt
> mv hg19_local.genome ~/igv/genomes/
```

最后，在igv中打开这个.genome文件。

