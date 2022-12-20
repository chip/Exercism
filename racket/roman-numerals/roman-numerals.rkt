#lang racket

(provide to-roman)

(define divisors '(1000 900 500 400 100 90 50 40 10 9 8 7 6 5 4 3 2 1))
(define numerals '("M" "CM" "D" "CD" "C" "XC" "L" "XL" "X" "IX" "VIII" "VII" "VI" "V" "IV" "III" "II" "I"))

(define (to-roman number)
  (let loop ([n number]
             [rn ""])
    (if (= n 0)
      rn
      (let* ([amt (first (filter (lambda (d) (>= n d)) divisors))])
        (loop (- n amt) (string-append rn (list-ref numerals (index-of divisors amt))))))))
