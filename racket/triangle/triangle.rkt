#lang racket

(provide triangle?)

(define (valid? a b c)
  (and (nor (zero? a) (zero? b) (zero? c))
       (and (>= (+ a b) c) (>= (+ b c) a) (>= (+ a c) b))))

(define (triangle? sides kind)
  (let ([a (first sides)]
        [b (second sides)]
        [c (third sides)])
    (if (not (valid? a b c))
      #f
      (cond [(symbol=? kind 'isosceles) (or (= a b) (= b c) (= a c))]
            [(symbol=? kind 'equilateral) (and (= a b) (= b c))]
            [(symbol=? kind 'scalene) (nor (= a b) (= b c) (= a c))]))))
