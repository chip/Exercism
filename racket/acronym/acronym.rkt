#lang racket

(provide acronym)

(define (sanitize s)
  (string-upcase (string-replace s #rx"[-_]" " ")))

(define (words s)
  (string-split (sanitize s) " "))

(define (first-letter word)
  (if (zero? (string-length word))
    ""
    (substring word 0 1)))

(define (acronym s)
  (string-join (map first-letter (words s)) ""))
