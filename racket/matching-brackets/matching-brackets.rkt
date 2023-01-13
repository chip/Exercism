#lang racket

(provide balanced?)

(define table (make-hash '((#\[ . 0) (#\] . 0) (#\{ . 0) (#\} . 0) (#\) . 0) (#\( . 0))))

(define (opening? c)
  (member c '(#\[ #\{ #\()))

(define (closing? c)
  (member c '(#\] #\} #\))))

(define (opening-for c)
  (cond [(equal? #\] c) #\[]
        [(equal? #\} c) #\{]
        [(equal? #\) c) #\(]))

(define (ending-allowed? c)
  (> (hash-ref table (opening-for c)) 0))

(define (matching-counts? o c)
  (= (hash-ref table o) (hash-ref table c)))

(define (balanced? str)
  (if (equal? str "")
    #f
    (for ([c (string->list str)])
      (when (opening? c)
        (hash-set! table c (add1 (hash-ref table c))))
      (when (closing? c)
        (if (ending-allowed? c)
          (hash-set! table (opening-for c) (sub1 (hash-ref table (opening-for c))))
          #f))))
  (and (matching-counts? #\[ #\]) (matching-counts? #\{ #\}) (matching-counts? #\( #\))))
