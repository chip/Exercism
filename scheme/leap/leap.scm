(import (rnrs))

(define (divisible? year divisor)
  (= (modulo year divisor) 0))

(define (leap-year? year)
  (cond ((divisible? year 400) #t)
        ((divisible? year 100) #f)
        ((divisible? year 4) #t)
        (else #f)))
