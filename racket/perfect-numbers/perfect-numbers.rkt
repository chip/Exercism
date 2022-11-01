#lang racket

(provide classify)

(define (factors number)
  (let ([numbers empty])
    (for ([i (range 1 number)]
          #:when (zero? (remainder number i)))
      (set! numbers (append numbers (list i))))
    numbers))

(define (classify number)
  (let ([x (for/sum ([i (factors number)]) i)])
    (cond
      [(= x number) 'perfect]
      [(< x number) 'deficient]
      [(> x number) 'abundant])))
