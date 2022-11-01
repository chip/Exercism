#lang racket

(require math)

(provide classify)

(define (classify number)
  (let ([x (for/sum ([i (drop-right (divisors number) 1)]) i)])
    (cond
      [(= x number) 'perfect]
      [(< x number) 'deficient]
      [(> x number) 'abundant])))
