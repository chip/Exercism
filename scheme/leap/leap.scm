(import (rnrs))

(define (evenly-divisible? year divisor)
  (eq? (modulo year divisor) 0))

(define (leap-year? year)
  (if (evenly-divisible? year 4)
    (if (evenly-divisible? year 100)
      (evenly-divisible? year 400)
      #t)
    #f))
