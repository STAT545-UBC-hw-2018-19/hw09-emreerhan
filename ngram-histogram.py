import numpy as np
import sys

def main():
    # First param is words file
    words_file = sys.argv[1]
    # Second param is size of n-grams
    n = sys.argv[2]
    ngrams_freq = dict()
    with open(words_file, 'r') as words:
        word = words.readline().strip().lower()
        while not word is '':
            for ngram in get_ngrams(word, int(n)):
                ngrams_freq[ngram] = ngrams_freq.get(ngram, 0) + 1 # Add 1 to frequency
            word = words.readline().strip().lower()
    print(ngrams_freq)


def get_ngrams(word, n = 3):
    """
    Return all n-grams of word
    """
    ngrams = [word[i:i+n] for i in range(len(word)-n+1)]
    return ngrams

if __name__ == '__main__':
    main()