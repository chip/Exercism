#lang racket

(provide balanced?)

; (har->integer #\))
; (integer->char 41)
;(define endings (list '[ '] '( ') '{ '})) |#
; TODO are ending counts needed? |#
; (define table (map cons '(#\[ #\] #\{ #\} #\( #\)) '(0 0 0 0 0 0)))

(define table (make-hash '(
                           (#\[ . 0)
                           (#\] . 0) 
                           (#\{ . 0)
                           (#\} . 0)
                           (#\) . 0)
                           (#\( . 0))))

; (displayln (list? table))
(define (closing-for c)
  (cond [(equal? #\[ c) #\]]
        [(equal? #\{ c) #\}]
        [(equal? #\( c) #\)]))

; TODO refactor '(#\[ ...) includes? c
(define (opening? c)
  (or 
    (equal? #\[ c)
    (equal? #\{ c)
    (equal? #\( c)))

; TODO refactor '(#\[ ...) includes? c
(define (closing? c)
  (or 
    (equal? #\] c)
    (equal? #\} c)
    (equal? #\) c)))

(define (opening-for c)
  (cond [(equal? #\] c) #\[]
        [(equal? #\} c) #\{]
        [(equal? #\) c) #\(]))

;; (cond [(equal? #\] c) (dict-ref table #\[ 0)] |#
;;       [(equal? #\} c) (dict-ref table #\{ 0)] |#
;;       [(equal? #\) c) (dict-ref table #\( 0)]) |#)

(define (ending-allowed? c)
  ; (displayln (format "ending-allowed? c: ~a opening-for: ~a hash-ref ~a" c (opening-for c) (hash-ref table (opening-for c))))
  (> (hash-ref table (opening-for c)) 0))

(define (balanced? str)
  (if (equal? str "")
    #f
    (for ([c (string->list str)])
      ;(displayln (format "c: ~a char->integer: ~a" c (char->integer c)))
      ;(displayln (format "table: ~v" table))
      (when (opening? c)
        (hash-set! table c (add1 (hash-ref table c))))
        ;(displayln (format "opening? table: ~v" table)))
      (when (closing? c)
        ; (displayln (format "closing? ~a" c))
        (if (ending-allowed? c)
          (begin
            ; (displayln (format "ending-allowed? ~a" c))
            (hash-set! table (opening-for c) (sub1 (hash-ref table (opening-for c)))))
            ;(displayln (format "closing? table: ~v" table)))
          #f))))

  ;(displayln (format "table: ~v" table))
  (and 
       (= (hash-ref table #\[) (hash-ref table #\]))
       (= (hash-ref table #\{) (hash-ref table #\}))
       (= (hash-ref table #\() (hash-ref table #\)))))
