#lang racket

(provide nucleotide-counts)

(define (parse s)
  (define nucleotides (make-hash '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0))))
  (for ([char (string->list s)])
    (hash-set! nucleotides char (add1 (hash-ref nucleotides char))))
  (for/list ([key (sort (hash-keys nucleotides) char<?)])
    (cons key (hash-ref nucleotides key))))

(define (valid? s)
  (when (non-empty-string? s)
    (regexp-match? #rx"^[ACGT]+$" s)))

(define (nucleotide-counts s)
  (when (not (valid? s))
    (error "invalid nucleotides"))
  (parse s))
