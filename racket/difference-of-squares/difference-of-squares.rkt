#lang racket

(provide sum-of-squares square-of-sum difference)

(define (number-range number)
  (range 1 (add1 number)))
  
(define (sum-of-squares number)
  (for/sum ([i (number-range number)]) (* i i)))

(define (sum-of number)
  (for/sum ([i (number-range number)]) i))

(define (square-of-sum number)
  (sqr (sum-of number)))

(define (difference number)
  (- (square-of-sum number) (sum-of-squares number)))
