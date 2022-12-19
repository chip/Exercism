#lang racket
(provide my-reverse)

(define (my-reverse s)
  (foldr (lambda (c acc) (string-append acc (string c)))
         ""
         (string->list s)))
