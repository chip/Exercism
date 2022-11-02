#lang racket

(provide hamming-distance)

(define (hamming-distance source target)
  (cond 
    [(= (string-length source) (string-length target))
     (count (negate equal?)
            (string->list source)
            (string->list target))]
    [else (error "String lengths are not equal")]))
