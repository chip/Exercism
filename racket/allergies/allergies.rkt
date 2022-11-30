#lang racket

(provide list-allergies allergic-to?)

(define (find-allergy score)
  (cond [(>= score 128) (cons 128 "cats")]
        [(>= score  64) (cons 64  "pollen")]
        [(>= score  32) (cons 32  "chocolate")]
        [(>= score  16) (cons 16  "tomatoes")]
        [(>= score   8) (cons 8   "strawberries")]
        [(>= score   4) (cons 4   "shellfish")]
        [(>= score   2) (cons 2   "peanuts")]
        [(>= score   1) (cons 1   "eggs")]
        [else (cons 0 #f)]))

(define threshold 256)

(define (list-allergies original-score)
  (let process ([lst empty]
                [score (modulo original-score threshold)])
    (let* ([allergy-pair (find-allergy score)]
           [allergy-score (car allergy-pair)]
           [allergy (cdr allergy-pair)])
      (if (or (zero? allergy-score) (not allergy))
        lst
        (process (append lst (list allergy)) (- score allergy-score))))))

(define (allergic-to? str score)
  (let ([lst (list-allergies score)])
    (and (member str lst) #t)))
