#lang racket

(provide to-rna)

(define (to-rna dna)
  (string-join
    (map
      (lambda (n) (hash-ref #hash(("G" . "C") ("C" . "G") ("T" . "A") ("A" . "U")) n))
      (map string (string->list dna)))
    ""))
