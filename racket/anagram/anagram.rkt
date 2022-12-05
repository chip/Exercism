#lang racket

(provide anagrams-for)

(define (frequencies s)
  (define table (make-hash))
  (for/list ([i (string->list (string-downcase s))])
    (hash-update! table i add1 0))
  table)

(define (anagram? s p)
  (cond [(not (= (string-length s) (string-length p))) #f]
        [(string-ci=? s p) #f]
        [(equal? (frequencies s) (frequencies p)) p]
        [else #f]))

(define (anagrams-for candidate possibilities)
  (filter string? (map (lambda (p) (anagram? candidate p)) possibilities)))
