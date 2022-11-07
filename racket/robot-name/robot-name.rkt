#lang racket

(provide make-robot
         name
         reset!
         reset-name-cache!)

(define ascii-offset-letters 65)
(define ascii-offset-numbers 48)

(define cache (make-hash))

(define (letters)
  (list->string
    (for/list ([i (in-range 2)])
      (integer->char (+ ascii-offset-letters (random 26))))))

(define (numbers)
  (list->string
    (for/list ([i (in-range 3)])
      (integer->char (+ ascii-offset-numbers (random 10))))))

(define (create-name)
  (string-append (letters) (numbers)))

(define (make-robot)
  (let ([name (create-name)])
    (hash-set! cache name name)
    name))

(define (name robot)
  (hash-ref cache robot))

(define (reset! robot)
  (hash-remove! cache name))

(define (reset-name-cache!)
  (hash-clear! cache))
