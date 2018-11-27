# size of n-grams for n-gram analysis
n?=3

all: word-report.html ngram-report.html

clean:
	rm -f words.txt *-histogram.tsv *-histogram.png *-report.md *-report.html

word: word-report.html

ngram: ngram-report.html

visual: makefile-visual.png

makefile-visual.png: makefile2dot/makefile2dot.py
	makefile2dot/makefile2dot.py <Makefile |dot -Tpng > makefile-visual.png

word-report.html: word-report.rmd word-histogram.tsv word-histogram.png
	Rscript -e 'rmarkdown::render("$<")'

ngram-report.html: ngram-report.rmd ngram-histogram.tsv ngram-histogram.png ngram-logy-histogram.png
	Rscript -e 'rmarkdown::render("$<")'

word-histogram.png: word-histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

ngram-histogram.png: ngram-histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Abundance, Freq, data=read.delim("$<"), size=I(0.2)); ggsave("$@")'
	rm Rplots.pdf
	
ngram-logy-histogram.png: ngram-histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Abundance, log10(Freq), data=head(read.delim("$<"), n = 1000), geom=c("point", "smooth"), size=I(0.2)); ggsave("$@")'
	rm Rplots.pdf

word-histogram.tsv: word-histogram.r words.txt
	Rscript $<

ngram-histogram.tsv: ngram-histogram.py words.txt
	python3 ngram-histogram.py words.txt $(n) > ngram-histogram.tsv

words.txt: /usr/share/dict/words
	cp $< $@

# words.txt:
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
