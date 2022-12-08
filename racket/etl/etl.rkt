#lang racket

(provide
  (contract-out
    [etl (-> (hash/c positive? (listof string?)) (hash/c string? positive?))]))

(define (etl input)
  (let ([h (make-hash)])
    (for ([(score letters) input])
      (for ([(letter) letters])
        (hash-set! h (string-downcase letter) score)))
    h))
