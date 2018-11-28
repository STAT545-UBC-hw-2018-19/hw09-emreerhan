# Homework 09: Automating Data-analysis Pipelines

In this homework I automate the generation of n-gram abundance histograms for all English words in Webster's Second International Dictionary. My contributions are:
* [A Python script for generating the histogram data](https://github.com/STAT545-UBC-students/hw09-emreerhan/blob/master/scripts/ngram-histogram.py)
* [An R markdown report of the histograms](https://github.com/STAT545-UBC-students/hw09-emreerhan/blob/master/scripts/ngram-report.rmd)
* Modifications to the Makefile to allow Jenny Bryan's words analysis, as well as this n-gram analysis
* Including a submodule of Github user vak's [implementation](https://github.com/vak/makefile2dot) of visualizing Makefiles to create the visual below.

## Visualization of Makefile pipeline

![A visualization of the pipeline](https://github.com/STAT545-UBC-students/hw09-emreerhan/blob/master/images/makefile-visual.png "A visualization of the pipeline")

## Reports

[Jenny Bryan's word length analysis](https://github.com/STAT545-UBC-students/hw09-emreerhan/blob/master/reports/word-report.md)

[My n-gram abundance histogram analysis](https://github.com/STAT545-UBC-students/hw09-emreerhan/blob/master/reports/ngram-report.md)

## Dependencies

### Python

```
Python 3.6.5
numpy 1.14.5
```

### R

```
R 3.5.1
ggplot2 3.1.0
```

## Usage

For all default analyses

```
make all
```

For just Jenny Bryan's word analysis

```
make word
```

For my n-gram analysis with n=3:

```
make ngram
```

To run the n-gram analysis with any n, for example 5:

```
make ngram n=5
```

To create the Makefile visualization:

```
make visual
```

## n-grams

From [wikipedia](https://en.wikipedia.org/wiki/N-gram):

> In the fields of computational linguistics and probability, an n-gram is a contiguous sequence of n items from a given sample of text or speech.

There are many applications of n-grams, however I am much more familiar with n-grams in the field of computational biology, where they're called k-mers. There are many useful things that can be learned from the set of n-grams from a text or a biological sequence. If you're interested, I encourage you to follow the link to the Wikipedia article above.

Abundance histograms of n-grams is often useful for downstream analysis of a text. An abundance histogram describes the frequency of n-grams that occur n times.

### A short example

For example for a text: "Thisistextextext" The set of 3-grams would be:

```
Thi
his
isi
sis
ist
tex
ext
xte
```
The abundance of 3-grams is:

|3-gram|Abundance|
|---|-|
|Thi|1|
|his|1|
|isi|1|
|sis|1|
|ist|1|
|tex|3|
|ext|3|
|xte|2|

So the resulting abundance histogram is:

|Abundance|Freq|
|-|-|
|1|5|
|2|1|
|3|2|

In this report, I will quickly present 2 plots of abundance histograms of 3-grams for all words found in Webster's Second International dictionary.

## Credit

This homework assignment was seeded from [STAT545's Make activity](https://github.com/STAT545-UBC/make-activity)

The visualization of the Makefile is done using [vak's makefile2dot script](https://github.com/vak/makefile2dot)
