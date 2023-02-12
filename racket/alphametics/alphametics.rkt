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
    (printf "p ~a\n" p)
    (let ([letter-map (make-hash (map cons letters (stream->list p)))])
      (and (first-letter-not-zero? letter-map)
           (solution-found? letter-map))))

  (define (build p)
    (printf "build ~a\n" p)
    (map (lambda (l n) (cons (string l) n)) letters p))

  (define result
    (for* ([c (in-combinations nums letters-len)]
           [p (in-permutations c)]
           #:when (solution? p))
      ; TODO need to terminate HERE!
      (build p)
      #f))

  (if result result '()))

(printf "= ~a\n" (solve "I + BB == ILL"))
