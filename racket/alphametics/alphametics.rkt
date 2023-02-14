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

  (define (first-letter-not-zero? lm)
    (andmap
      (lambda (c)
        (not (zero? (hash-ref lm c 'ERROR-first-letter-not-zero))))
      first-letters))

  ; (define (list->number lst)
  ;   (string->number (string-join (map number->string lst) "")))
  ;
  ; (define (lhs-sum lst)
  ;   (for/sum ([i (map list->number lst)]) i))
  ;
  ; (define (eq-sum? e)
  ;   (let* ([lhs (take e (sub1 (length e)))]
  ;          [rhs (last e)])
  ;     (= (lhs-sum lhs) (list->number rhs))))

  ; (define (map-word w lm)
  ;   (map (lambda (c) (hash-ref lm c 'ERROR-map-word)) (string->list w)))

  ; POSSIBLE FUTURE APPROACH
  ; TODO use global hash to store 26 unit assn pairs: (#\A . (char->integer #\A))
  ; TODO each letter in puzzle should have a digit assigned from a
  ; permutation, which should be mapped over the global immutable hash (a copy),
  ; and incremented by permutation value which is reset upon each new
  ; permutation (by virtue of the immutable original)

  (define (solution-found? lm)
    (printf "solution-found? ~a\n" lm)
    ; TODO how to cache or memoize?
    ; TODO use lm instead of letters, nums for rgxs
    (define rgxs (map
                   (lambda (k v) (list (string k) (number->string v)))
                   (hash-keys lm) (hash-values lm)))
    (let* ([s (regexp-replaces puzzle rgxs)]
           ; [los (map string-trim (string-split s #rx"==|[+]"))]
           [lon (map string->number (string-split s " "))]
           [lhs (take lon (sub1 (length lon)))]
           ; [lhs-nums (map string->number lhs)]
           ; [rhs (string->number (last los))]
           [rhs (last lon)]
           [sum (foldl + 0 lhs)])
      ; (printf "ns ~a\n" ns)
      ; (printf "los ~a\n" los)
      ; (printf "lon ~a\n" lon)
      ; (printf "lon v ~v\n" lon)
      ; (printf "lhs ~a\n" lhs)
      ; (printf "lhs v ~v\n" lhs)
      ; (printf "list? lhs ~a\n" (list? lhs))
      ; (printf "lhs-nums ~a\n" lhs-nums)
      ; (printf "rhs ~a\n" rhs) (printf "sum ~a\n" sum)
      (printf "lhs = ~a sum ~a rhs ~a equal? ~a\n" lhs sum rhs (= sum rhs))
      (= sum rhs)))
    
  ; (define (_solution-found? lm)
  ;   (let ([e (map (lambda (w) (map-word w lm)) words)])
  ;     (eq-sum? e)))

  (define (solution? p)
    ; (printf "p seq? ~a\n" (sequence? p))
    ; (printf "sequence->list ~a\n" (sequence->list p))
    (let ([letter-map (make-hash (map cons letters p))])
      (and (first-letter-not-zero? letter-map)
           (solution-found? letter-map))))

  ; TODO make hash global
  (define (build p)
    (printf "build letters ~a p ~a\n" letters p)
    (map (lambda (l n) (cons (string l) n)) letters p))

  (define (generate-combinations)
    (sequence->list (in-combinations nums letters-len)))

  ; TODO could promises be used here?
  (define (generate-permutations)
    (define seen (make-hash))
    (let loop-c ([c (generate-combinations)])
      (printf "c ~a first ~a\n" c (first c))
      (if (empty? c)
        '()
        (let loop-p ([perm (sequence->list (in-permutations (first c)))])
          (let ([p (first perm)])
            ; TODO get first p from list
            (printf "p ~v\n" p)
            (if (hash-ref seen p #f)
              (begin
                (printf "SEEN! ~v\n" p))
              (begin
                (hash-set! seen p #t)
                (cond [(empty? p) (loop-c (rest c))]
                      [(solution? (first p)) (first p)]
                      [else (loop-p (rest p))]))))))))

  ; (define (translate-string str tbl)
  ;   (define (lookup ch)
  ;     (hash-ref tbl ch ch))
  ;   (list->string (map lookup (string->list str))))
  ;
  ; (define (make-translation-table from to)
  ;   (define tbl (make-hash))
  ;   (for ([i (in-range (string-length from))])
  ;     (hash-set! tbl (string-ref from i) (string-ref to i)))
  ;   tbl)
  ;
  ; (define tbl (make-translation-table "aeiou" "12345"))
  ; (printf "tbl ~a\n" tbl)
  ; (printf "translate ~a\n" (translate-string "hello world" tbl))

  (let ([res (generate-permutations)])
    (if (empty? res)
      '()
      (build res))))

(printf "solve => ~a\n" (solve "NO + NO + TOO == LATE"))
; '(("N" . 7))
; ("O" . 4)
; ("T" . 9)
; ("L" . 1)
; ("A" . 0)
; ("E" . 2))
; (printf "solve => ~a\n" (solve "I + BB == ILL")
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
