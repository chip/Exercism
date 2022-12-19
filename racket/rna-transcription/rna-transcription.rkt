#lang racket

(provide to-rna)

(define (lookup char) 
  (hash-ref #hash((#\G . "C") (#\C . "G") (#\T . "A") (#\A . "U")) char))

(define (to-rna dna)
  (string-join (map lookup (string->list dna)) ""))
