#lang racket

(provide list-allergies allergic-to?)

(define allergies (hash
                    1 "eggs"
                    2 "peanuts"
                    4 "shellfish"
                    8 "strawberries"
                    16 "tomatoes"
                    32 "chocolate"
                    64 "pollen"
                    128 "cats"))

(define allergy-names (hash
                        "eggs" 1
                        "peanuts" 2
                        "shellfish" 4
                        "strawberries" 8
                        "tomatoes" 16
                        "chocolate" 32
                        "pollen" 64
                        "cats" 128))

(define (scores)
  (reverse (sort (hash-keys allergies) <)))

(define (find-allergy score)
  (cond [(>= 128) "cats"]
        [(>=  64) "pollen"]
        [(>=  32) "chocolate"]
        [(>=  16) "tomatoes"]
        [(>=   8) "strawberries"]
        [(>=   4) "shellfish"]
        [(>=   2) "peanuts"]
        [(>=   1) "eggs"]
        [else #f]))

(define (allergy-list orig-score)
  (let process ([lst empty]
                [score (normalize-score orig-score)])
    (let* ([allergy (find-allergy score)]
           [allergy-score (hash-ref allergy-names allergy)])
      (displayln (format "lst ~a | score ~a | allergy ~a | allergy-score ~a" lst score allergy allergy-score))
      (if (zero? score)
        lst
        (process (append lst (list allergy)) (- score allergy-score))))))

(define (normalize-score score)
  (if (> score 256)
    (modulo score 128)
    score))

;(normalize-score 509)
;(allergy-list 256)

;(for/sum ([i (hash-keys allergies)]) i)
; START steps
;(modulo 509 256) ; 253
;(- 253 128) ; subtract "cats" score, leaving 125
;(- 125 64) ; subtract "pollen" score, leaving 61
;(- 61 32) ; subtract "chocolate" score, leaving 29
;(- 29 16) ; subtract "tomatoes" score, leaving 13
;(- 13 8) ; subtract "strawberries" score, leaving 5
;(- 5 4) ; subtract "shellfish" score, leaving 1
;(- 1 1) ; subtract "eggs" score, leaving 0
; DONE at zero!
; END steps
(define alg '(
              (128 cats)
              ( 64 pollen)
              ( 32 chocolate)
              ( 16 tomatoes)
              (  8 strawberries)
              (  4 shellfish)
              (  2 peanuts)
              (  1 eggs)))

;(define (a-list score)
(define (list-allergies score)
  (let go ([matches empty]
           [remaining-pairs alg]
           [remaining-score (modulo score 256)])
    ;(displayln (format "m ~a | rp ~a | rs ~a" matches remaining-pairs remaining-score))
    (let* ([candidate (argmax car remaining-pairs)]
           [candidate-score (car candidate)])
      ;(displayln (format "cs ~a | rs ~a" candidate-score remaining-score))
      (if (> candidate-score remaining-score)
        (remove candidate remaining-pairs)
        (if (and candidate (> remaining-score 0) (>= remaining-score (car candidate)))
          (go (append matches candidate) (cdr remaining-pairs) (- remaining-score (car candidate)))
          matches)))))

;(a-list 509)

;(lists-equiv? "non allergen score parts"
;             (list-allergies 509)
;             '("eggs" "shellfish" "strawberries" "tomatoes"
;                 1        4           8              16
;               "chocolate" "pollen" "cats"))
;                 32            64     128
; total 253
;(map (lambda (key) (hash-ref allergy-names key)) (hash-keys allergy-names))

;(hash->list allergies)
; sort allergies by score, highest to lowest: 128, 64, etc.
; return allergy str if score >= allergy score
; subtract allergy score from score argmax
; recur
(define (___list-allergies score)
  (map (lambda (str) (allergic-to? str score)) (hash-keys allergies)))

(define (allergic-to? str score)
  (cond [(= score (hash-ref allergy-names str)) #t]
        [(> score (hash-ref allergy-names str)) #t]
        [else #f]))
