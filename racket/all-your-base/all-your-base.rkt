#lang racket

(provide rebase)

(define (invalid-arguments? b1 b2)
  (or (< b1 2) (<= b2 1) (negative? b2)))

(define (format-list result b2)
  (displayln (format "format-list [result ~v] [b2 ~v]" result b2))
  (if (= b2 10)
    (list (for/sum ([i result]) i))
    (filter-map string->number (regexp-split #rx"" (number->string (first result))))))


(define (to-base-10 list-digits b1 b2)
  (let process ([lst (reverse list-digits)]
                [position 0]
                [result '()])
    ;(displayln (format "[lst: ~v] [position: ~v] [result: ~v]" lst position result))
    (if (empty? lst)
      ;(list result)
      ;result
      (format-list result b2)
      (let ([digit (car lst)])
        (displayln (format "[digit ~v] [lst ~v] [result ~v] [list? result ~v]" digit lst result (list? result)))
        (if (or (>= digit b1) (negative? digit))
          #f
          ;(process (cdr lst) (add1 position) (append result (list (* digit (expt b1 position))))))))))))
          (if (positive? digit)
            (process (cdr lst) (add1 position) (append result (list (* digit (expt b1 position)))))
            (process (cdr lst) (add1 position) result)))))))
  
(define (list->number lst)
  (string->number (string-join (map ~a lst) "")))

; 2 5
;   2 R1
;   1 R0 
;divide n by b2 successively
(define (base10->b2 list-digits b2)
  (let ([z (list->number list-digits)])
    ;(let-values process ([(q r) (quotient/remainder n b2)]))
    (let process ([n z]
                  [remainders empty])
      (let* ([q (quotient n b2)]
             [r (remainder n b2)])
        (displayln (format "n ~v | q ~v | r ~v | remainders ~v" n q r remainders))
        (if (zero? q)
          (append remainders (list r))
          (process q (append remainders (list r))))))))

;(base10->b2 '( 5) 2)

(define (rebase list-digits b1 b2)
  (if (invalid-arguments? b1 b2)
    #f
    (if (empty? list-digits)
      '( 0)
      (cond [(= b1 10) (base10->b2 list-digits b2)]
            [(= b2 10) (to-base-10 list-digits b1 b2)]
            [else (error 'whooops)]))))
    

;(rebase '( 5 ) 10 2)
(define (___rebase list-digits b1 b2)
  (if (invalid-arguments? b1 b2)
    #f
    (if (empty? list-digits)
      '( 0)
      (let process ([lst (reverse list-digits)]
                    [position 0]
                    [result '()])
        ;(displayln (format "[lst: ~v] [position: ~v] [result: ~v]" lst position result))
        (if (empty? lst)
          ;(list result)
          ;result
          (format-list result b2)
          (let ([digit (car lst)])
            (displayln (format "[digit ~v] [lst ~v] [result ~v] [list? result ~v]" digit lst result (list? result)))
            (if (or (>= digit b1) (negative? digit))
              #f
              ;(process (cdr lst) (add1 position) (append result (list (* digit (expt b1 position))))))))))))

              (if (positive? digit)
                (process (cdr lst) (add1 position) (append result (list (* digit (expt b1 position)))))
                (process (cdr lst) (add1 position) result)))))))))
