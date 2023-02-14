#lang racket

(require racket/trace)
(provide solve)

(define (solve puz)
  (printf "puzzle: ~a\n" puz)
  (define words (regexp-split #rx"==|[+]" (string-replace puz " " "")))
  (define puzzle (string-join words " "))
  ; (define words (regexp-split #rx"==|[+]" (string-replace puzzle " " "")))
  (define letters (remove-duplicates (string->list (string-join words ""))))
  (printf "letters{~a}\n" letters)
  (define letters-len (length letters))
  (define first-letters (remove-duplicates (map first (map string->list words))))
  (printf "first-letters{~a}\n" first-letters)

  ; Used to generate combinations
  (define nums (range 10))
  ; Check that a solution is possible
  (when (> letters-len (length nums))
    '())

  ; (printf "and ~a\n" (and #t #t))
  (define (first-letter-not-zero? lm)
    (andmap
      (lambda (c)
        ; (printf "notzero? ~a | v ~a | c ~a | fl ~a | lm ~a\n"  (not (zero? (hash-ref lm c 'ERROR-first-letter-not-zero))) (hash-ref lm c 'ERRtest) c first-letters lm)
        (not (zero? (hash-ref lm c 'ERROR-first-letter-not-zero))))
      first-letters))

  (define (translate-string str tbl)
    (define (lookup ch)
      (hash-ref tbl ch ch))
    (list->string (map lookup (string->list str))))

  (define (make-translation-table from to)
    (define tbl (make-hash))
    (for ([i (in-range (string-length from))])
      (hash-set! tbl (string-ref from i) (string-ref to i)))
    tbl)

  (define (solution-found? lm p)
    ; (printf "solution-found? ~a p ~a\n" lm p)
    (let ([ps (string-join (map number->string p) "")]
          [ls (string-join (map string letters) "")])
      ; (printf "ps list->string ~a\n" ps)
      ; (printf "ls list->string ~a\n" ls)
      ; TODO how to cache or memoize?
      ; (printf "puzzle ~a\n" puzzle)
      (define tbl (make-translation-table ls ps))
      ; (printf "tbl ~a\n" tbl)
      (let* ([lhs (translate-string puzzle tbl)]
             [los (string-split lhs " ")]
             [lon (map string->number los)]
             [lhs-sum (foldl + 0 (take lon (sub1 (length lon))))]
             [rhs-sum (string->number (last los))])
        ; (printf "lhs-sum ~a\n" lhs-sum)
        ; (printf "last words ~a\n" (last words))
        ; (printf "lhs ~a rhs ~a eq? ~a\n" lhs-sum rhs-sum (= lhs-sum rhs-sum))
        (= lhs-sum rhs-sum))))

  ; (define tbl (make-translation-table "aeiou" "12345"))
  ; (printf "tbl ~a\n" tbl)
  ; (printf "translate ~a\n" (translate-string "hello world" tbl))

  ; TODO make hash global
  (define (build p)
    (printf "build letters ~a p ~a\n" letters p)
    (map (lambda (l n) (cons (string l) n)) letters (hash-values p)))

  ; TODO Necessary?
  (define generate-combinations
    (sequence->list (in-combinations nums letters-len)))

  ; >>> solve_cryptarithm(['SEND', 'MORE'], 'MONEY')
  ; letters: NMDSOREY
  ; initial_letters: MS
  ; perm: ('0', '1', '2', '3', '4', '5', '6', '7')
  ; decipher_table: {78: 48, 77: 49, 68: 50, 83: 51, 79: 52, 82: 53, 69: 54, 89: 55}
  ; TODO could promises be used here?
  (define generate-permutations
    (let loop-c ([combos generate-combinations])
      ; (printf "combos ~a\n" combos)
      (printf "c ~a\n" (first combos))
      (if (empty? combos)
        '()
        (let loop-p ([perms (sequence->list (in-permutations (first combos)))])
          ; (printf "perm ~v\n" perm)
          (if (empty? perms)
            (loop-c (rest combos))
            (let* ([p (first perms)]
                   [lm (make-hash (map cons letters p))])
              ; TODO map first letters to permutation
              ; (printf "p ~v\n" p)
              (if (and (first-letter-not-zero? lm) (solution-found? lm p))
                lm
                (loop-p (rest perms)))))))))

  (let ([res generate-permutations])
    (if (empty? res)
      '()
      (build res))))

; (printf "solve => ~a\n" (solve "NO + NO + TOO == LATE"))
; '(("N" . 7))
; ("O" . 4)
; ("T" . 9)
; ("L" . 1)
; ("A" . 0)
; ("E" . 2))
; (printf "solve => ~a\n" (solve "I + BB == ILL"))
; (printf "solve => ~a\n") (solve "A + A + A + A + A + A + A + A + A + A + A + B == BCC")
; '(("A" . 9)
;   ("B" . 1)
;   ("C" . 0))
; (printf "solve => ~a\n" (solve "AS + A == MOM"))
; '(("A" . 9))
; ("S" . 2)
; ("M" . 1)
; ("O" . 0))
; (printf "solve => ~a\n" (solve "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE"))
; '(("A" . 5)
;   ("N" . 0)
;   ("D" . 3)
;   ("S" . 6)
;   ("T" . 9)
;   ("R" . 1)
;   ("O" . 2)
;   ("G" . 8)
;   ("F" . 7)
;   ("E" . 4)))
;
