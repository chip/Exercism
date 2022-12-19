#lang racket

(provide convert)

(define h #hash((3 . "Pling") (5 . "Plang") (7 . "Plong")))

(define (drops? n)
  (string-join
    (filter-map
      (lambda (m)
        (if (zero? (modulo n m))
          (hash-ref h m)
          #f))
      (hash-keys h))
    ""))

(define (convert n)
  (if (non-empty-string? (drops? n))
    (drops? n)
    (number->string n)))
