#lang racket

(provide encode decode)

(define plain '(a b c d e f g h i j k l m n o p q r s t u v w x y z))
(define cipher '(z y x w v u t s r q p o n m l k j i h g f e d c b a))

(define (s->cipher s)
  (if (regexp-match? #px"[a-z]" s)
    (symbol->string (list-ref cipher (index-of plain (string->symbol s))))
    s))

(define (s->plain s)
  (if (regexp-match? #px"[a-z]" s)
    (symbol->string (list-ref plain (index-of cipher (string->symbol s))))
    s))

(define (convert-chunk lst)
  (map (lambda (w)
         (map s->cipher (map string (string->list w))))
      lst))

(define (build-5-letter-strings s)
  (regexp-match* #px"(.{1,5})" (regexp-replace* #rx"[,. ]" (string-downcase s) "")))

(define (join-chunks lst)
  (string-append "" (string-join lst "")))

(define (encode m)
  (string-join (map join-chunks (convert-chunk (build-5-letter-strings m))) " "))

(define (decode m)
  (let ([s (string-replace m " " "")])
    (string-join
      (map (lambda (c)
             (if (regexp-match? #px"[a-z]" c)
               (symbol->string (list-ref plain (index-of cipher (string->symbol c))))
               c))
           (map string (string->list s)))
      "")))
