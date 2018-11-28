# size of n-grams for n-gram analysis
n?=3

all: word ngram visual

clean:
	rm -f data/words.txt data/*-histogram.tsv images/*-histogram.png images/makefile-visual.png reports/*-report.md reports/*-report.html

word: reports/word-report.html

ngram: reports/ngram-report.html

visual: images/makefile-visual.png

images/makefile-visual.png: makefile2dot/makefile2dot.py
	mkdir -p images
	makefile2dot/makefile2dot.py <Makefile |dot -Tpng > images/makefile-visual.png

reports/word-report.html: scripts/word-report.rmd data/word-histogram.tsv images/word-histogram.png
	mkdir -p reports
	Rscript -e 'rmarkdown::render("$<")'
	mv scripts/word-report.html reports
	mv scripts/word-report.md reports

reports/ngram-report.html: scripts/ngram-report.rmd data/ngram-histogram.tsv images/ngram-histogram.png images/ngram-logy-histogram.png
	mkdir -p reports
	Rscript -e 'rmarkdown::render("$<")'
	mv scripts/ngram-report.html reports
	mv scripts/ngram-report.md reports
	
images/word-histogram.png: data/word-histogram.tsv
	mkdir -p images
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

images/ngram-histogram.png: data/ngram-histogram.tsv
	mkdir -p images
	Rscript -e 'library(ggplot2); qplot(Abundance, Freq, data=read.delim("$<"), size=I(0.2)); ggsave("$@")'
	rm Rplots.pdf
	
images/ngram-logy-histogram.png: data/ngram-histogram.tsv
	mkdir -p images
	Rscript -e 'library(ggplot2); qplot(Abundance, log10(Freq), data=head(read.delim("$<"), n = 1000), geom=c("point", "smooth"), size=I(0.2)); ggsave("$@")'
	rm Rplots.pdf

data/word-histogram.tsv: scripts/word-histogram.r data/words.txt
	mkdir -p data
	Rscript $<
	mv word-histogram.tsv data

data/ngram-histogram.tsv: scripts/ngram-histogram.py data/words.txt
	python3 $< data/words.txt $(n) > $@

data/words.txt: /usr/share/dict/words
	cp $< $@

# words.txt:
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
