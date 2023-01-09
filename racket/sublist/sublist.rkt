#lang racket

(provide sublist?)

(define (sublist-found? s l)
  ;(displayln (format "s ~a l ~a" s l))
  (if (empty? s)
    #t
    (let loop ([l l])
      (if (empty? l)
        #f
        (let* ([ele (first s)]
               [i (index-of l ele)]
               [len (length s)])
          ;(displayln (format "ele ~a i ~a" ele i))
          (if (not i)
            #f
            (if (> len (length l))
              #f
              (let ([remaining (drop l i)])
                (if (> len (length remaining))
                  #f
                  (let ([sl (take remaining len)])
                    (when (equal? s '(1 2 3))
                      (displayln (format "s ~a l ~a sl ~a" s l sl)))
                    (if (equal? s sl)
                      #t
                      (loop (rest remaining)))))))))))))

(define (sublist? s l)
  (if (equal? s l)
    'equal
    (if (empty? s)
      'sublist
      (if (empty? l)
        'superlist
        (cond [(sublist-found? s l) 'sublist]
              [(sublist-found? l s) 'superlist]
              [else 'unequal])))))
