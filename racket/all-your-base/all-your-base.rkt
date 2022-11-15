#lang racket

(provide rebase)

(define (invalid-arguments? b1 b2)
  (or (< b1 2) (<= b2 1) (negative? b2)))

(define (rebase list-digits b1 b2)
  (if (invalid-arguments? b1 b2)
    #f
    (if (empty? list-digits)
      '( 0)
      (let process ([lst (reverse list-digits)]
                    [position 0]
                    [result empty])
        (displayln (format "[lst: ~v] [position: ~v] [result: ~v]" lst position result))
        (if (empty? lst)
          (list result)
          (let ([digit (car lst)])
            (if (or (>= digit b1) (negative? digit))
              #f
              (if (positive? digit)
                (process (cdr lst) (add1 position) (append result (* digit (expt b1 position))))
                (process (cdr lst) (add1 position) (append result empty))))))))))
    
(rebase '( 0 6 0 ) 7 10)
;(test-equal? "leading-zeros"
;             '( 4 2)
;             (rebase '( 0 6 0 ) 7 10))))))))

;(define (_rebase list-digits b1 b2)
;  (if (or (empty? list-digits) (negative? b1) (negative? b2))
;    #f
;    (let go ([result empty]
;             [lst (reverse list-digits)])
;      ;(displayln (format "result: ~v" result))
;      ;(displayln (format "lst ~v" lst))
;      (if (empty? lst)
;        (reverse (list result))
;        (let* ([n (car lst)]
;               [rem (remainder n b2)])
;          (go (list (append (list result) rem)) (cdr lst)))))))
;
; Convert to base 10 first
; Convert result by dividing by b2, saving remainder (last remainder is first-most digit in result)

; Convert   '( 1 0 1 ) b1=2, b2=10
; Position:    2 1 0
; (1 * (b1 ^ 2)) + (0 * (b1 ^ 1)) + (1 * (b1 ^ 0))
; (1 * (2  * 2)) + (0 * (2)) + (1 * (1))
; (1 * 4)        + (0 * 2)   + (1 * 1))
; 4              + 0              + 1
; 5

;(rebase '( 1 0 1 ) 2 10)
;     (test-equal? "binary-to-single-decimal"
;                  '( 5)
;                  (rebase '( 1 0 1 ) 2 10)))
