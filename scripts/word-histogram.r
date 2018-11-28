words <- readLines("data/words.txt")
Length <- nchar(words)
hist_dat <- table(Length)
write.table(hist_dat, "word-histogram.tsv",
						sep = "\t", row.names = FALSE, quote = FALSE)
