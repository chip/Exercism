#lang racket

(require profile)

(provide solve)

(define nums (range 10))
(define nums-len (length nums))

(define (solve puzzle)
  (define words (regexp-split #rx"==|[+]" (string-replace puzzle " " "")))

  (define letters
    (for/fold ([acc '()]
               #:result acc)
              ([x (string->list (string-join words ""))])
      (cond
        [(member x acc) (values acc)]
        [else (values (append acc (list x)))])))

  (define first-letters (list->set (map (lambda (w) (substring w 0 1)) words)))

  (when (> (length letters) nums-len)
    '())

  (define (word->sum word h)
    (string-join
      (map
        (lambda (c) (number->string (dict-ref h c)))
        (string->list word)) ""))

  (define (make-equation o)
    (for/fold ([acc '()]
               #:result acc)
              ([word words])
      (cond
        [(member word acc) (values acc)]
        [else (values (append acc (list (word->sum word o))))])))

  ; TODO necessary to pass h as arg?
  (define (is-first-letter-of-word-zero? p h)
    (printf "is-first-letter-of-word-zero p ~a h ~a\n" p h)
    (ormap
      (lambda (s)
        ; (printf "s ~a\n" s)
        (zero? (dict-ref h s #f)))
      (set->list first-letters)))

  (define (lhs-sum te)
    ; (printf "lhs-sum te ~a\n" te)
    (for/sum ([i (map string->number (take te (sub1 (length te))))]) i))

  (define (solution-found? p)
    (let ([e (make-equation (map (lambda (s n) (cons s n)) letters p))])
      ; (printf "solution-found? p ~a e ~a\n" p e)
      ; (printf "? ~a\n" (= (string->number (last e)) (lhs-sum e)))
      ; TODO use string=? instead of converting to number?
      (= (string->number (last e)) (lhs-sum e))))

  (define (solution? p h)
    ; (printf "solution? p ~a h ~a ? ~a\n" p h (and (not (is-first-letter-of-word-zero? p h)) (solution-found? p)))
    (and (not (is-first-letter-of-word-zero? p h)) (solution-found? p)))

  (define (generate-permutations items size)
    (if (zero? size)
      '(())
      (for/list ([t (in-list (generate-permutations items (- size 1)))]
                 #:when #t
                 [i (in-list items)]
                 #:unless (member i t))
        (cons i t))))

  (define solution
    (filter-not false?
      ; (lambda (b) (not (false? b)))
      (map
        (lambda (p)
          ; (printf "map p ~a\n" p)
          (let ([h (make-hash (map cons letters p))])
            ; (printf "let h ~a\n" h)
            ; (printf "map p ~a h ~a\n" p h)
            (if (solution? p h)
              (map (lambda (k) (cons (string k) (hash-ref h k))) letters)
              #f)))
        (generate-permutations (range 10) (length letters)))))

  (let ([r solution])
    (if (empty? r)
      r
      (first r))))

; (define h (make-hash '(("I" . 7) ("B" . 9) ("L" . 3))))
; (define h (make-hash '((#\I . 7) (#\B . 9) (#\L . 3))))
; (string-join
;   (map
;     (lambda (c) (number->string (dict-ref h c)))
;     (string->list "BIL")) "") ; => 973
;(printf "solve 1 result: ~a\n" (solve "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE"))
; (printf "solve result: ~a\n" (solve "I + BB == ILL"))
;              '(("I" . 1)
;                ("B" . 9)
;                ("L" . 0)))
