#lang racket

(provide nanp-clean)

(define (nanp-clean s)
  (let* ([r (string-replace s #rx"[.()+-]|\\ " "")]
         [len (string-length r)])
    (cond [(regexp-match? #rx"[a-z]" r) (error 'invalid-with-letters)]
          [(regexp-match? #rx"[@:!]" r) (error 'invalid-with-punctuation)]
          [(regexp-match? #rx"^0" r) (error 'area-code-starts-with-zero)]
          [(= len 11) (if (not (regexp-match? #rx"^1" r))
                        (error '11-digits-must-start-with-1)
                        (begin
                          (when (equal? #\0 (string-ref r 1))
                            (error 'area-code-starts-with-one-for-11-digits))
                          (when (equal? #\1 (string-ref r 1))
                            (error 'area-code-starts-with-one-for-11-digits))
                          (when (equal? #\0 (string-ref r 4))
                            (error 'exchange-code-starts-with-zero-for-11-digits))
                          (when (equal? #\1 (string-ref r 4))
                            (error 'exchange-code-starts-with-one-for-11-digits))
                          (string-replace r #rx"^1" "")))]
          [(regexp-match? #rx"^1" r) (error 'area-code-starts-with-one)]
          [(= len 9) (error 'invalid-9-digits)]
          [(> len 11) (error 'invalid-more-than-11-digits)]
          [(equal? #\0 (string-ref r 3)) (error 'exchange-code-starts-with-zero)]
          [(equal? #\1 (string-ref r 3)) (error 'exchange-code-starts-with-one)]
          [else r])))
