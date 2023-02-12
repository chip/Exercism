#lang racket

(provide perm)

(define (perm size)
  (define numz (range 10))
  (for ([p (in-permutations 3)])
    ;([c (combinations numz size)])
        ;[p (in-permutations c)])
    (printf "c ~a\n" p)
    p))

; (I . 1) (B . 9) (L . 0)
(printf "result: ~a\n" (perm 3))
