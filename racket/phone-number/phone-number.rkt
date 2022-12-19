#lang racket

(provide nanp-clean)
(define (nanp-clean s)
  (define (sanitize s) (string-replace s #rx"[^0-9]" ""))
  (define (re s) (regexp-match #px"1?([2-9]\\d{2})([2-9]\\d{2})(\\d{4})" s))
  (let* ([r (sanitize s)]
         [matches (re r)]
         [len (string-length r)])
    (if (or (> len 11) (and (= len 11) (not (regexp-match #rx"^(1|\\+1)" s))) (not matches))
      (error 'invalid-phone-number)
      (string-join (rest matches) ""))))
