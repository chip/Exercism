#lang racket

(provide acronym)

(define (sanitize s)
  (string-upcase (string-replace s #rx"[-_]" " ")))

(define (words s)
  (string-split s " "))

(define (acronym s)
  (string-join (map (lambda (word)
                      (if (zero? (string-length word))
                        ""
                        (substring word 0 1))) (words (sanitize s))) ""))
