#lang racket

(provide nucleotide-counts)

(define (nucleotide-counts s)
  (if (nor (regexp-match? #rx"^[ACGT]+$" s) (not (non-empty-string? s)))
    (error "invalid nucleotides")
    (for/fold ([acc '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0))])
      ([char s])
      (dict-update acc char add1))))
