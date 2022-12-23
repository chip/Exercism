#lang racket

(provide word-count)

(define (word-count s)
  (define t (make-hash))
  (for ([w (words s)])
    (hash-update! t w add1 0))
  t)

(define (words s)
  (map string-downcase (string-split (sanitize s) #rx" ")))

(define (sanitize s)
  (string-normalize-spaces (remove-word-quotes (remove-quotes-keep-contractions (remove-puncuation s)))))

(define (remove-puncuation s)
  (regexp-replace* #rx"[:!&@$%^&.,\"]" s " "))

(define (remove-quotes-keep-contractions s)
  (regexp-replace* #rx"'([^t])" s "\\1"))

(define (remove-word-quotes s)
  (regexp-replace* #rx"'(.+)'" s "\\1"))
