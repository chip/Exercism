#lang racket

(provide
  (contract-out
    [etl (-> (hash/c positive? (listof string?)) (hash/c string? positive?))]))

(define scores (hash "a" 1 "e" 1 "i" 1 "o" 1 "u" 1 "l" 1 "n" 1 "r" 1 "s" 1 "t" 1
                     "d" 2 "g" 2
                     "b" 3 "c" 3 "m" 3 "p" 3
                     "f" 4 "h" 4 "v" 4 "w" 4 "y" 4
                     "k" 5
                     "j" 8 "x" 8
                     "q" 10 "z" 10))

(define (hash->strings input)
  (map string-downcase (filter string? (flatten (hash-values input)))))

(define (etl input)
  (for/hash ([s (hash->strings input)])
    (values s (hash-ref scores s))))
