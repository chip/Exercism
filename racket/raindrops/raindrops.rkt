#lang racket

(provide convert)

(define (drops? n)
  (define h #hash((3 . "Pling") (5 . "Plang") (7 . "Plong")))
  (string-join
    (filter-map
      (lambda (m) (if (zero? (modulo n m)) (hash-ref h m) #f))
      (hash-keys h))
    ""))

(define (convert n)
  (let ([result (drops? n)])
    (if (non-empty-string? result)
      result
      (number->string n))))
