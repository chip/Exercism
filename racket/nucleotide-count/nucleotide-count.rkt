#lang racket

(provide nucleotide-counts)

(define nucleotides (make-hash))

(define (reset-count)
  (for ([char (list #\A #\C #\G #\T)])
    (hash-set! nucleotides char 0)))

(define (hash->list)
  (printf "hash->list\n")
  (for/list ([key (sort (hash-keys nucleotides) char<?)])
    (cons key (hash-ref nucleotides key))))
    
(define (parse s)
  (printf "parse\n")
  (for ([char (string->list s)])
    (let ([n (hash-ref nucleotides char)])
      (hash-set! nucleotides char (add1 n))))
  (hash->list)) 

(define (valid? s)
  (regexp-match? #rx"^[ACGT]+$" s))

(define (nucleotide-counts s)
  (reset-count)
  (if (not (valid? s))
    (error "invalid nucleotides")
    (if (non-empty-string? s)
      (parse s)
      (hash->list))))
