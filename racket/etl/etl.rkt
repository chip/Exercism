#lang racket

(provide etl)

(define scores (hash "a" 1 "e" 1 "i" 1 "o" 1 "u" 1 "l" 1 "n" 1 "r" 1 "s" 1 "t" 1
                     "d" 2 "g" 2
                     "b" 3 "c" 3 "m" 3 "p" 3
                     "f" 4 "h" 4 "v" 4 "w" 4 "y" 4
                     "k" 5
                     "j" 8 "x" 8
                     "q" 10 "z" 10))

(define (negative-keys? input)
  (not (empty? (filter negative-integer? (hash-keys input)))))

(define (non-string-values? input)
  (empty? (filter string? (first (hash-values input)))))

(define (hash->strings input)
  (map string-downcase (filter string? (flatten (hash-values input)))))

(define (convert input)
  (for/hash ([s (hash->strings input)])
    (values s (hash-ref scores s))))

(define (etl input)
  (if (hash-empty? input)
    (make-hash)
    (cond [(negative-keys? input) (raise-argument-error 'negative-keys-input)]
          [(non-string-values? input) (raise-argument-error 'non-string-values)]
          [else (convert input)])))
