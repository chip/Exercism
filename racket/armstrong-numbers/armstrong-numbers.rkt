#lang racket

(provide armstrong-number?)

(define (armstrong-number? n)
  (= n (for/sum ([i (nums n)]) i)))

(define (nums n)
  (let* ([s (~v n)]
         [w (string-length s)])
    (for/list ([c (string->list s)])
      (expt (- (char->integer c) 48) w))))
