#lang racket

(provide rebase)

(define (invalid-arguments? b1 b2)
  (or (< b1 2) (<= b2 1) (negative? b2)))

(define (number->list n)
  (filter-map string->number (regexp-split #rx"" (number->string (first n)))))

(define (format-list n b2)
  (if (= b2 10)
    (number->list (list (for/sum ([i n]) i)))
    (number->list n)))

(define (to-base-10 lst b1 b2)
  (let process ([lst (reverse lst)]
                [position 0]
                [result '()])
    (if (empty? lst)
      (format-list result b2)
      (let ([digit (car lst)])
        (if (or (>= digit b1) (negative? digit))
          #f
          (process (cdr lst) (add1 position) (append result (list (* digit (expt b1 position))))))))))
  
(define (list->number lst)
  (string->number (string-join (map ~a lst) "")))

(define (base10->b2 lst b2)
  (let ([z (list->number lst)])
    (let process ([n z]
                  [remainders empty])
      (let* ([q (quotient n b2)]
             [r (remainder n b2)])
        (if (zero? q)
          (reverse (append remainders (list r)))
          (process q (append remainders (list r))))))))

(define (rebase lst b1 b2)
  (if (invalid-arguments? b1 b2)
    #f
    (if (empty? lst)
      '( 0)
      (cond [(= b1 10) (base10->b2 lst b2)]
            [(= b2 10) (to-base-10 lst b1 b2)]
            [else (base10->b2 (to-base-10 lst b1 10) b2)]))))
