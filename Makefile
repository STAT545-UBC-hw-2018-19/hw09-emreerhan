all: word-report.html

clean:
	rm -f words.txt word-histogram.tsv word-histogram.png word-report.md word-report.html

word-report.html: word-report.rmd word-histogram.tsv word-histogram.png
	Rscript -e 'rmarkdown::render("$<")'

word-histogram.png: word-histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

word-histogram.tsv: word-histogram.r words.txt
	Rscript $<

words.txt: /usr/share/dict/words
	cp $< $@

# words.txt:
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
