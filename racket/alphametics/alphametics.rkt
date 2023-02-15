#lang racket

(require racket/trace)
(provide solve)

(define (solve puz)
  ; (printf "puzzle: ~a\n" puz)
  (define words (regexp-split #rx"==|[+]" (string-replace puz " " "")))
  (define puzzle (string-join words " "))
  ; (define words (regexp-split #rx"==|[+]" (string-replace puzzle " " "")))
  (define letters (map char->integer (remove-duplicates (string->list (string-join words "")))))
  ; (define letters (remove-duplicates (string->list (string-join words ""))))
  ; (printf "letters{~a}\n" letters)
  ; (printf "letters char? {~a}\n" (map char->integer letters))
  (define letters-len (length letters))
  (define first-letters (map char->integer (remove-duplicates (map first (map string->list words)))))
  ; (printf "first-letters{~a}\n" first-letters)

  (define zero-dec (char->integer #\0))
  ; Used to generate combinations
  ; (define nums (reverse (range 10)))
  (define nums (reverse (range 57 (sub1 zero-dec) -1)))
  ; (printf "nums ~a\n" nums)
  ; Check that a solution is possible
  (when (> letters-len (length nums))
    '())

  ; (printf "and ~a\n" (and #t #t))
  (define (first-letter-not-zero? lm)
    ; (printf "flnz lm ~a\n" lm)
    (andmap
      (lambda (c)
        ; (printf "notzero? ~a | v ~a | c ~a\n"
        ;         (not (= zero-dec (hash-ref lm c 'ERROR-first-letter-not-zero)))
        ;         (hash-ref lm c 'ERRtest)
        ;         c)
        (not (= zero-dec (hash-ref lm c 'ERROR-first-letter-not-zero))))
        ; (not (zero? (hash-ref lm c 'ERROR-first-letter-not-zero))))
      first-letters))

  (define (translate-string str tbl)
    (define (lookup ch)
      (hash-ref tbl ch ch))
    (list->string (map lookup (string->list str))))

  (define (make-translation-table from to)
    (define tbl (make-hash))
    (for ([i (in-range (length from))])
      (hash-set! tbl
                 (list-ref from i)
                 (list-ref to i)))
    tbl)

  (define (solution-found? lm p)
    ; (printf "solution-found? ~a p ~a\n" lm p)
    ; (let ([ps (string-join (map p) "")]
    ;       [ls (string-join (map string letters) "")])
    ; (printf "ps list->string ~a\n" ps)
    ; (printf "ls list->string ~a\n" ls)
    ; TODO how to cache or memoize?
    ; (printf "puzzle ~a\n" puzzle)
    (define tbl (make-translation-table letters p))
    ; (printf "tbl ~a\n" tbl)
    (define (lookup word)
      (map (lambda (c) (hash-ref tbl (char->integer c))) (string->list word)))
    ; (printf "=>> ~a\n" (translate-string puzzle tbl))
    ; (printf "=>> ~a\n" (string-split (translate-string puzzle tbl) " "))
    (let* ([lhs (translate-string puzzle tbl)]
           [los (string-split lhs " ")]
           ; TODO Start here
           [loln (map lookup los)]
           ; [f (printf "los ~a\n" los)]
           ; [g (printf "loln ~a\n" loln)]
           ; [m (map (lambda (n) (printf "~v number? ~a\n" n (char? n))) loln)]
           ; [m (printf "m ~a\n" m)]
           [lol (map lookup los)]
           [lol-sum (map (lambda (lon) (foldl + 0 lon)) lol)]
           ; [z (printf "lol-sum ~a\n" lol-sum)]
           [lhs-sum (foldl + 0 (take lol-sum (sub1 (length lol-sum))))]
           [rhs-sum (last lol-sum)])
      ; (printf "lon ~a\n" (map string->number los))
      ; (printf "lhs-sum ~a\n" lhs-sum)
      ; (printf "rhs-sum ~a\n" rhs-sum)
      ; (printf "= lhs ~a rhs ~a sum ~a\n" lhs-sum rhs-sum (= lhs-sum rhs-sum))
      ; (printf "last words ~a\n" (last words))
      ; (printf "lhs ~a rhs ~a eq? ~a\n" lhs-sum rhs-sum (= lhs-sum rhs-sum))
      ; (when (= lhs-sum rhs-sum))
      ; (printf "pz ~a lhs ~a los ~a lhs ~a rhs ~a eq? ~a\n" puzzle lhs los lhs-sum rhs-sum (= lhs-sum rhs-sum)))
      ; (printf "pz ~a lhs ~a los ~a ps ~a ls ~a lhs ~a rhs ~a eq? ~a\n" puzzle lhs los ps ls lhs-sum rhs-sum (= lhs-sum rhs-sum)))
      (= lhs-sum rhs-sum)))

  ; TODO make hash global
  (define (build p)
    ; (printf "build letters ~a p ~a\n" letters p)
    (map
      (lambda (l n) (cons l n))
      (map (lambda (c) (string (integer->char c))) letters)
      (map (lambda (n) (- n zero-dec)) (hash-values p))))

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
      ; (printf "c ~a\n" (first combos))
      (if (empty? combos)
        '()
        (let loop-p ([perms (sequence->list (in-permutations (first combos)))])
          ; (printf "perms ~v\n" perms)
          (if (empty? perms)
            (loop-c (rest combos))
            (let* ([p (first perms)]
                   [lm (make-hash (map cons letters p))])
                                       
                   ; [lm (make-hash (map cons letters p))])
              ; TODO map first letters to permutation
              ; (when (member zero-dec p)
              ;   (printf "p ~v ~a\n" p zero-dec))
              ; (printf "lm ~v\n" lm)
              (if (and (first-letter-not-zero? lm)
                       (solution-found? lm p))
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
