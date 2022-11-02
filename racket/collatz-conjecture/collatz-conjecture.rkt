#lang racket

(provide collatz)

(define steps 0)

(define (collatz num)
  (cond 
    [(zero? num) (error exn:fail #t)]
    [(negative? num) (error exn:fail #t)]
    [(not (integer? num)) (error exn:fail #t)]
    [(= 1 num) (let ([result steps])
                 (set! steps 0)
                 result)]
    [else
      (set! steps (add1 steps))
      (cond
        [(even? num) (collatz (/ num 2))]
        [(odd? num) (collatz (add1 (* num 3)))]
        [else (error exn:fail #t)])]))
