#lang racket

(provide solve)

(define (solve puzzle)
  (define nums (range 10))
  (define words (regexp-split #rx"==|[+]" (string-replace puzzle " " "")))
  (define lhs (take words (sub1 (length words))))
  (define rhs (last words))
  (define letters (remove-duplicates (string->list (string-join words ""))))
  (define letters-len (length letters))
  (define first-letters (remove-duplicates (map first (map string->list words))))

  (when (> letters-len (length nums))
    '())

  (define (first-letter-not-zero? lm)
    (andmap
      (lambda (c)
        (not (zero? (hash-ref lm c 'ERROR-first-letter-not-zero))))
      first-letters))

  (define (list->number lst)
    (string->number (string-join (map number->string lst) "")))

  (define (lhs-sum lst)
    (for/sum ([i (map list->number lst)]) i))

  (define (eq-sum? e)
    (let* ([lhs (take e (sub1 (length e)))]
           [rhs (last e)])
      (= (lhs-sum lhs) (list->number rhs))))

  (define (map-word w lm)
    (map (lambda (c) (hash-ref lm c 'ERROR-map-word)) (string->list w)))

  (define (solution-found? lm)
    (let ([e (map (lambda (w) (map-word w lm)) words)])
      (eq-sum? e)))

  (define (solution? p)
    (let ([letter-map (make-hash (map cons letters (sequence->list p)))])
      (and (first-letter-not-zero? letter-map)
           (solution-found? letter-map))))

  (define (build p)
    (map (lambda (l n) (cons (string l) n)) letters p))

  (define (generate-combinations)
    (sequence->stream (in-combinations nums letters-len)))

  (define (generate-permutations)
    (let combo-loop ([combo-strm (generate-combinations)])
      (if (stream-empty? combo-strm)
        '()
        (let perm-loop ([perms-strm (sequence->stream (in-permutations (stream-first combo-strm)))])
          (cond [(stream-empty? perms-strm) (combo-loop (stream-rest combo-strm))]
                [(solution? (stream-first perms-strm)) (stream-first perms-strm)]
                [else (perm-loop (stream-rest perms-strm))])))))

  (let ([res (generate-permutations)])
    (if (empty? res)
      '()
      (build res))))
