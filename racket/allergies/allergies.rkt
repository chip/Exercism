#lang racket

(provide list-allergies allergic-to?)

(define allergy-names (hash
                        "eggs" 1
                        "peanuts" 2
                        "shellfish" 4
                        "strawberries" 8
                        "tomatoes" 16
                        "chocolate" 32
                        "pollen" 64
                        "cats" 128))

(define (find-allergy score)
  (cond [(>= score 128) "cats"]
        [(>= score  64) "pollen"]
        [(>= score  32) "chocolate"]
        [(>= score  16) "tomatoes"]
        [(>= score   8) "strawberries"]
        [(>= score   4) "shellfish"]
        [(>= score   2) "peanuts"]
        [(>= score   1) "eggs"]
        [else #f]))

(define (normalize-score score)
  (if (> score 256)
    (modulo score 128)
    score))

(define (list-allergies orig-score)
  (let process ([lst empty]
                [score (normalize-score orig-score)])
    (if (zero? score)
      lst
      (let ([allergy (find-allergy score)])
        (if (not allergy)
          lst
          (let ([allergy-score (hash-ref allergy-names allergy)])
            (unless (zero? allergy-score)
              (process (append lst (list allergy)) (- score allergy-score)))))))))

(define (allergic-to? str score)
  (let ([lst (list-allergies score)])
    (and (member str lst) #t)))
