#lang racket

(provide my-length
         my-reverse
         my-map
         my-filter
         my-fold
         my-append
         my-concatenate)

(define (my-length sequence)
  (let loop ([sequence sequence]
             [sum 0])
    (if (empty? sequence)
      sum
      (loop (rest sequence) (add1 sum))))) 

(define (my-reverse sequence)
  (let loop ([sequence sequence]
             [lst empty])
    (if (empty? sequence)
      (flatten lst) 
      (loop (drop-right sequence 1)
            (append (list lst) (list (last sequence))))))) 

(define (my-map operation sequence)
  (let loop ([sequence sequence]
             [lst empty])
    (if (empty? sequence)
      (flatten lst) 
      (let* ([x (first sequence)]
             [result (operation x)])
        (loop (rest sequence) (append (list lst) (list result)))))))

(define (my-filter operation? sequence)
  (let loop ([sequence sequence]
             [lst empty])
    (if (empty? sequence)
      (flatten lst) 
      (if (operation? (first sequence))
        (loop (rest sequence) (append (list lst) (first sequence)))
        (loop (rest sequence) (list lst))))))

(define (my-fold operation accumulator sequence)
  (error "Not implemented yet"))

(define (my-append sequence1 sequence2)
  (error "Not implemented yet"))

(define (my-concatenate sequence-of-sequences)
  (error "Not implemented yet"))
