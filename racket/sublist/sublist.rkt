#lang racket

(provide sublist?)

(define (inside? s l)
  ;(displayln (format "inside? s ~a l ~a" s l))
  ;(displayln (format "ndx ~a" ndx))
  (let ([s-len (length s)]
        [l-len (length l)])
    (if (> s-len l-len)
      #f
      (if (empty? s)
        #f 
        (if (not (and (member (first s) l) (member (last s) l)))
          #f
          (let* ([s-elem (first s)]
                 [ndx (index-of l s-elem)])
            (for ([i (range s-len)]) 
              (if (not (= (list-ref l (+ i ndx)) (list-ref s i)))
                #f
                #t))))))))

(define (sublist? s l)
  (cond [(equal? s l) 'equal]
        [(> (length s) (length l)) 'superlist]
        [(and (< (length s) (length l)) (inside? s l)) 'sublist]
        [else 'unequal]))
