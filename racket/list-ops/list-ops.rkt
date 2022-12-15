#lang racket

(provide my-length
         my-reverse
         my-map
         my-filter
         my-fold
         my-append
         my-concatenate)

(define (my-length sequence)
  (for/sum ([_ sequence]) 1))

(define (my-reverse sequence)
  (my-fold cons '() sequence))

(define (my-map operation sequence)
  (for/list ([i sequence])
    (operation i)))

(define (my-filter operation? sequence)
  (for/list ([i sequence]
             #:when (operation? i))
    i))

(define (my-fold operation accumulator sequence)
  (if (empty? sequence)
    accumulator
    (my-fold operation (operation (first sequence) accumulator) (rest sequence))))

(define (my-append sequence1 sequence2)
  (my-fold cons sequence2 (my-reverse sequence1)))

(define (my-concatenate sequence-of-sequences)
  (my-fold my-append '() (my-reverse sequence-of-sequences)))
