## GNU make - how to get 2nd or 3rd prerequisite file

在写`makefile`的时候，有时候依赖文件有多个，并且需要分别使用。例如，需要把两个vcf合并（两个vcf文件是对应不同染色体的，所以直接cat就可以，但是对于第二个vcf文件不需要开头的行首为‘#’的meta信息部分。

```
target: vcf1 vcf2
	(cat vcf1; cat vcf2 | grep -v '#') | bgzip > $@
```
	
简单一点的写法是：

```
target： vcf1 vcf2
	(cat $<; cat $(word 2,$^) | grep -v '#') | bgzip > $@
```

多个依赖文件就有点不太方便：
		
```
target： vcf1 vcf2 vcf3
	(cat $<; cat $(word 2,$^) $(word 3,$^) | grep -v '#') | bgzip > $@
```
	
这时候可以用 `$(filter-out)`函数

```
target: vcf1 vcf2 vcf3
	(cat $<; cat $(filter-out $<,$^) | grep -v '#') | bgzip > $@
```

## GNU Make - multiple targets in one recipe and parallel execution

Inspired by `http://stackoverflow.com/questions/19822435/multiple-targets-from-one-recipe-and-parallel-execution.`

很多时候，写`makefile`的时候，一条rule可以产生多个target，但是这样有一个问题，假如这些target不是pattern rules，make对于其中每一个target，都会运行一次recipe。

例如：
```
bwa: hg19.fa.amb hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa

hg19.fa.amb hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa: hg19.fa
	bwa index -a bwtsw $<
```

当执行的时候，无论是否并行，`bwa index`命令都会被执行多次。

```
> make -n bwa
bwa index -a bwtsw hg19.fa
bwa index -a bwtsw hg19.fa
bwa index -a bwtsw hg19.fa
bwa index -a bwtsw hg19.fa
bwa index -a bwtsw hg19.fa
> make -j 5 -n bwa
bwa index -a bwtsw hg19.fa
bwa index -a bwtsw hg19.fa
bwa index -a bwtsw hg19.fa
bwa index -a bwtsw hg19.fa
bwa index -a bwtsw hg19.fa
```

解决的办法有两个。

第一种是当多个target可以写成`pattern rule`的时候：

```
bwa: hg19.fa.amb hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa

%.fa.amb %.fa.ann %.fa.bwt %.fa.pac %.fa.sa: %.fa
      bwa index -a bwtsw $<

> make -n bwa
bwa index -a bwtsw hg19.fa
> make -n -j 4 bwa
bwa index -a bwtsw hg19.fa
```


第二种方法是上面提到的网页里面的方法，这个方法适应性更广，适合不能写成`pattern rule`的情况。

```
bwa: hg19.fa.amb hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa

hg19.fa.amb: hg19.fa
	bwa index -a bwtsw $< && touch hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa

hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa: hg19.fa.amb

> make -n bwa
bwa index -a bwtsw hg19.fa && touch hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa
> make -n -j 4 bwa
bwa index -a bwtsw hg19.fa && touch hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa
```

解释一下，`hg19.fa.amb: hg19.fa`只把hg19.fa.amb当做target，但是命令`bwa index`生成了所有其余的target，包括hag9.fa.ann等文件，接下来命令`touch`重新改变了剩余几个文件的修改时间，使得它们比hg19.fa.amb更新，于是最后一个rule是已经满足了不需要被执行的。
	
进一步改进一下，写成更通用的形式：

```
bwa_obj = hg19.fa.amb hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa

bwa: $(bwa_obj)

first_obj = $(firstword $(bwa_obj))
rest_obj  = $(wordlist 2,$(words $(bwa_obj)),$(bwa_obj))

$(first_obj): hg19.fa
	bwa index -a bwtsw hg19.fa && touch $(rest_obj)
$(rest_obj): $(first_obj)

> make -n bwa
bwa index -a bwtsw hg19.fa && touch hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa
> make -n -j 5 bwa
bwa index -a bwtsw hg19.fa && touch hg19.fa.ann hg19.fa.bwt hg19.fa.pac hg19.fa.sa
```
