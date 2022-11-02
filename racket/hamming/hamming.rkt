#lang racket

(provide hamming-distance)

(define (hamming-distance source target)
  (cond 
    [(= (string-length source) (string-length target))
     (let ([distance 0])
      (map
        (lambda (x y)
          (cond 
            [(not (eq? x y)) (set! distance (add1 distance))]))
        (string->list source) (string->list target)) distance)]
    [else (error "String lengths are not equal")]))
