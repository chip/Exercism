#lang racket

(provide to-roman)

(define (to-roman number)
  (let loop ([acc ""]
             [n number])
    (if (zero? n)
      acc
      (cond [(>= n 1000) (loop (string-append acc    "M") (- n 1000))]
            [(>= n  900) (loop (string-append acc   "CM") (- n  900))]
            [(>= n  500) (loop (string-append acc    "D") (- n  500))]
            [(>= n  400) (loop (string-append acc   "CD") (- n  400))]
            [(>= n  100) (loop (string-append acc    "C") (- n  100))]
            [(>= n   90) (loop (string-append acc   "XC") (- n   90))]
            [(>= n   50) (loop (string-append acc    "L") (- n   50))]
            [(>= n   40) (loop (string-append acc   "XL") (- n   40))]
            [(>= n   10) (loop (string-append acc    "X") (- n   10))]
            [(>= n    9) (loop (string-append acc   "IX") (- n    9))]
            [(>= n    8) (loop (string-append acc "VIII") (- n    8))]
            [(>= n    7) (loop (string-append acc  "VII") (- n    7))]
            [(>= n    6) (loop (string-append acc   "VI") (- n    6))]
            [(>= n    5) (loop (string-append acc    "V") (- n    5))]
            [(>= n    4) (loop (string-append acc   "IV") (- n    4))]
            [(>= n    3) (loop (string-append acc  "III") (- n    3))]
            [(>= n    2) (loop (string-append acc   "II") (- n    2))]
            [(>= n    1) (loop (string-append acc    "I") (- n    1))]
            [else acc]))))
