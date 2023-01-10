#lang racket

(provide sublist?)

(define (sublist-found? s l)
  (if (empty? s)
    #t
    (if (empty? l)
      #f
      (if (list-prefix? s l)
        #t
        (let* ([len (length s)]
               [i (index-of l (first s))])
          (if (or (not i) (> len (length l)))
            #f
            (let ([remaining (drop l i)])
              (if (> len (length remaining))
                #f
                (if (equal? s (take remaining len))
                  #t
                  (sublist-found? s (rest remaining)))))))))))

(define (sublist? s l)
  (cond [(= (length s) (length l)) (if (equal? s l) 'equal 'unequal)]
        [(< (length s) (length l)) (if (sublist-found? s l) 'sublist 'unequal)]
        [else (if (sublist-found? l s) 'superlist 'unequal)]))
