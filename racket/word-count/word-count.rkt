#lang racket

(provide word-count)

(define (word-count s)
  (define t (make-hash))
  (for ([w (regexp-match* #px"[\\w]+('[\\w]+)?" s)])
    (hash-update! t (string-downcase w) add1 0))
  t)
