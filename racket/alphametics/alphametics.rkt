#lang racket

(provide solve)

(define nums (range 10))

(define (solve puzzle)
  (define words (regexp-split #rx"==|[+]" (string-replace puzzle " " "")))
  (define lhs (take words (sub1 (length words))))
  (define rhs (last words))
  (define letters (remove-duplicates (string->list (string-join words ""))))
  (define letters-len (length letters))
  (define first-letters
    (remove-duplicates (map first (map string->list words))))

  (when (> letters-len (length nums))
    '())

  (define (first-letter-not-zero? lm)
    (andmap
      (lambda (c) (not (zero? (dict-ref lm c 'ERROR-first-letter-not-zero))))
      (set->list first-letters)))

  (define (list->number lst)
    (string->number (string-join (map number->string lst) "")))

  (define (lhs-sum lst)
    (for/sum ([i (map list->number lst)]) i))

  (define (eq-sum? e)
    (let* ([lhs (take e (sub1 (length e)))]
           [rhs (last e)])
      (= (lhs-sum lhs) (list->number rhs))))

  (define (map-word w lm)
    (map (lambda (c) (dict-ref lm c 'ERROR-map-word)) (string->list w)))

  (define (solution-found? lm)
    (let ([e (map (lambda (w) (map-word w lm)) words)])
      (eq-sum? e)))

  (define (solution? p)
    (let ([letter-map (make-hash (map cons letters (stream->list p)))])
      (and (first-letter-not-zero? letter-map)
           (solution-found? letter-map))))

  (define (generate-permutations items size)
    (gen-perm items size '()))

  (define (gen-perm items size acc)
    (if (zero? size)
      '(())
      (for/list ([t (in-list (gen-perm items (- size 1) acc))]
                 #:when #t
                 [i (in-list items)]
                 #:unless (member i t))
        (append acc (cons i t)))))
  
  (define (build p)
    (map (lambda (l n) (cons (string l) n)) letters p))

  (define result 
    (for/first ([p (in-list (generate-permutations nums letters-len))]
                #:when (solution? p))
      (build p)))

  (if result result '()))
