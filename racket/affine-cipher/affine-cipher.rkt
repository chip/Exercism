#lang racket/base

(require racket/contract)
(require racket/list)
(require racket/string)
(require (only-in math/number-theory coprime? pairwise-coprime?))

(provide (contract-out
          [encode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]
          [decode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]))

(define n-chars 5)
(define m 26)
(define ascii-offset 97)
(define ascii-offset-numbers 48)
(define fmt "c: ~v, i: ~v, x: ~v, p: ~v, r: ~v, z: ~v")

; `E(x) = (ax + b) mod m`)
(define (Ex c a b)
  (if (not (pairwise-coprime? a m))
    (raise-argument-error "a is not coprime to m")
    (if (char-numeric? c)
      c
      (let* ([i (char->integer c)]
             [x (- i ascii-offset)]
             [p (+ (* a x) b)]
             [r (remainder p m)]
             [z (integer->char (+ r ascii-offset))])
        ;(if (equal? c "a")
        ;  (displayln (format fmt c i x p r z))
        ;  ""
        (if (integer? x)
          z
          c)))))
    
(define (add-whitespace lst)
  (if (>= (length lst) n-chars)
    (flatten
      (list (take lst n-chars) #\space (add-whitespace (drop lst n-chars))))
    lst))
        
(define (allowed? c)
  (cond
    [(char-numeric? c) #t]
    [(char-alphabetic? c) #t]
    [else #f]))

(define (characters msg)
  (filter allowed? (string->list (string-downcase msg))))

(define (encode msg a b)
  (string-trim (list->string (add-whitespace (map (lambda (c) (Ex c a b)) (characters msg))))))

(define (decode msg a b)
  (error "Not implemented yet"))
