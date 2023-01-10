#lang racket

;(require seq)
(provide sublist?)

(define (subl? s l)
  ;(displayln (format "l ~a s ~a" l s))
  (if (null? l)
    #f
    (if (list-prefix? s l)
      #t
      (let ([fi (index-of l (first s))]
            [li (index-of l (last s))])
        (displayln (format "fi ~a  li ~a  length ~a" fi li (length l)))
        (if (or (false? fi) (false? li))
          #f
          (subl? s (rest l)))))))

;(define (sublist? s l)
;  ;(displayln (format "s: ~a l: ~a" s l))
;  (if (equal? s l)
;    'equal
;    (if (empty? s)
;      'sublist
;      (begin
;        (if (empty? l)
;          'superlist
;          (cond [(and (< (length s) (length l)) (sublist-found? s l)) 'sublist]
;                [(and (< (length l) (length s)) (sublist-found? l s)) 'superlist]
;                [else 'unequal]))))))
;
;#lang racket
;
;(provide sublist?)

(define (_subl? s l)
  (cond
    [(null? l) #f]
    [(list-prefix? s l) #t]
    [(not (index-of l (first s))) #f]
    [(not (index-of l (last s))) #f]
    [else (_subl? s (cdr l))]))

(define (sublist? s l)
  (let ([len (length s)]
        [len2 (length l)])
    (cond
      [(= len len2) (if (equal? s l) 'equal 'unequal)]
      [(> len len2) (if (subl? l s) 'superlist 'unequal)]
      [else (if (subl? s l) 'sublist 'unequal)])))
