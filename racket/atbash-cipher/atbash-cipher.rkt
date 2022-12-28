#lang racket

(provide encode decode)

(define alphabet '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z))
(define ending-index (sub1 (length alphabet)))
(define ascii-offset 97)

(define (lookup-char c)
  (if (char-numeric? c)
    (string c)
    (if (char-lower-case? c)
      (string (integer->char (+ ascii-offset (- ending-index (index-of alphabet c)))))
      #f)))

(define (parse s)
  (regexp-match* #px"(.{1,5})" s #:match-select cadr))

(define (sanitize-string->list s)
  (string->list (regexp-replace* #rx"[,. ]" (string-downcase s) "")))

(define (encode m)
  (string-join (parse (string-join (filter-map lookup-char (sanitize-string->list m)) ""))))

(define (decode m)
  (string-join (filter-map lookup-char (string->list m)) ""))
