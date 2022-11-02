#lang racket

(provide collatz)

(define collatz
  (case-lambda
    [(n) (if (exact-positive-integer? n)
             (collatz n 0)
             (error "Value must be a positive integer"))]
    [(n total)
     (cond
      [(= n 1) total]
      [(even? n) (collatz (/ n 2) (add1 total))]
      [else (collatz (add1 (* n 3)) (add1 total))])]))
