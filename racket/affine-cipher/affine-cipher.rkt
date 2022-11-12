#lang racket/base

(require racket/contract)
(require racket/list)
(require racket/string)
(require (only-in math/number-theory coprime?))

(provide (contract-out
          [encode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]
          [decode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]))

(define m 26)
(define ascii-offset 97)
(define n-chars 5)

(define (encode-character char a b)
  (if (not (coprime? a m))
    (raise-argument-error "a and b must be coprime.")
    (if (char-numeric? char)
      char
      (let* ([i (char->integer char)]
             [x (- i ascii-offset)]
             [p (+ (* a x) b)]
             [r (remainder p m)]
             [z (integer->char (+ r ascii-offset))])
          z))))
    
(define (add-whitespace lst)
  (if (< (length lst) n-chars)
    lst
    (flatten (list (take lst n-chars) #\space (add-whitespace (drop lst n-chars))))))
        
(define (allowed? c)
  (cond
    [(char-numeric? c) #t]
    [(char-alphabetic? c) #t]
    [else #f]))

(define (characters msg)
  (filter allowed? (string->list (string-downcase msg))))

(define (encode msg a b)
  (string-trim (list->string (add-whitespace (map (lambda (char) (encode-character char a b)) (characters msg))))))

(define (mmi a)
 (first (filter exact-positive-integer? (map (lambda (i) (/ (+ (* i m) 1) a)) (range 1 m)))))

(define (decode-character char a b)
  (if (char-numeric? char)
    (string char)
    (let* ([y (- (char->integer char) ascii-offset)]
           [rem (modulo (* (mmi a) (- y b)) m)]
           [orig (integer->char (+ ascii-offset rem))])
      (string orig))))

(define (decode msg a b)
  (if (not (coprime? a m))
    (raise-argument-error "a and b must be coprime.")
    (string-join (map (lambda (char) (decode-character char a b)) (filter allowed? (string->list msg))) "")))
