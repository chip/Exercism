#lang racket

(provide nucleotide-counts)

(define (parse s)
  (define nucleotides (make-hash))
  (for ([char (list #\A #\C #\G #\T)])
    (hash-set! nucleotides char 0))
  (for ([char (string->list s)])
    (let ([n (hash-ref nucleotides char)])
      (hash-set! nucleotides char (add1 n))))
  (for/list ([key (sort (hash-keys nucleotides) char<?)])
    (cons key (hash-ref nucleotides key))))

(define (valid? s)
  (if (non-empty-string? s)
    (regexp-match? #rx"^[ACGT]+$" s)
    #t))

(define (nucleotide-counts s)
  (when (not (valid? s))
    (error "invalid nucleotides"))
  (parse s))
