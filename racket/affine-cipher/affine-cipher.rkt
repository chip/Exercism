#lang racket/base
(require racket/contract)
(require racket/string)
(require racket/list)

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
(define fmt "c: ~v x: ~v z: ~v")

; `E(x) = (ax + b) mod m`)
(define (Ex c a b)
  (let* ([i (char->integer c)]
         [x (- i ascii-offset)]
         [p (+ (* a x) b)]
         [r (remainder p m)]
         [z (integer->char (+ r ascii-offset))])
    ;(displayln (format fmt c x z))
    (if (exact-positive-integer? x)
      z
      c))) 
  
(define (add-whitespace lst)
  (if (>= (length lst) n-chars)
    (flatten (list (take lst n-chars) #\space (add-whitespace (drop lst n-chars))))
    lst))
        
;(add-whitespace (string->list "mindblowingly"))

(define (encode msg a b)
  (list->string
    (add-whitespace
      (map
        (lambda (c)
          (Ex c a b))
        (filter char-alphabetic? (string->list (string-downcase msg)))))))

(define (decode msg a b)
  (error "Not implemented yet"))
