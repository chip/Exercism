#lang racket

(provide leap-year?)

(define (leap-year? year)
  (cond ((zero? (remainder year 400)) #t)
        ((zero? (remainder year 100)) #f)
        ((zero? (remainder year 4)) #t)
        (else #f)))
