#lang racket

;; Converts integers to English-language descriptions
(require racket/contract)

(define/contract (two-digit-number? n)
  (any/c . -> . boolean?)
  (and (>= n 0) (< n 100)))

(provide

  (contract-out
    [step1 (-> two-digit-number? string?)]
    ;; Convert a positive, 2-digit number to an English string

    [step2 (-> exact-nonnegative-integer? (listof integer?))]
    ;; Divide a large positive number into a list of 3-digit (or smaller) chunks

    [step3 (-> exact-integer? (listof (cons/c integer? symbol?)))]
    ;; Break a number into chunks and insert scales between the chunks

    [step4 (-> exact-integer? string?)]))
    ;; Convert a number to an English-language string

;; =============================================================================
(define under-20 (vector "zero" "one" "two" "three" "four" "five" "six" "seven" "eight"
                         "nine" "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen"
                         "sixteen" "seventeen" "eighteen" "nineteen"))

(define tens (vector "zero" "ten" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))

(define (n->list n)
  (map string->number (map string (string->list (number->string n)))))

(define (step1 n)
  (let ([lst (n->list n)])
    (match lst
      [(list a) (vector-ref under-20 n)]
      [(list a b) (cond [(zero? b) (vector-ref tens a)]
                        [(< n 20) (vector-ref under-20 n)]
                        [else (string-append (vector-ref tens a) "-" (vector-ref under-20 b))])])))

(define (step2 N)
  (define (pos lst)
    (min (length lst) 3))

  (let loop ([lst (filter number? (n->list N))]
             [acc '()])
    (let* ([num (string->number (string-join (map number->string (take-right lst (pos lst))) ""))])
      (if (empty? lst)
        acc
        (loop (drop-right lst (pos lst)) (append (list num) acc))))))

(define (step3 n)
  (let ([lst (step2 n)])
    (match lst
      [(list tr b m t h) (list (cons tr 'trillion) (cons b 'billion) (cons m 'million) (cons t 'thousand) (cons h 'END))]
      [(list b m t h) (list (cons b 'billion) (cons m 'million) (cons t 'thousand) (cons h 'END))]
      [(list   m t h) (list (cons m 'million) (cons t 'thousand) (cons h 'END))]
      [(list     t h) (list (cons t 'thousand) (cons h 'END))]
      [(list       h) (list (cons h 'END))])))

(define (step4 N)
  (if (zero? N)
    "zero"
    (let* ([s3 (step3 N)]
           [prefix (if (negative? N) "negative " "")])
      (string-append
        prefix
        (string-join
          (filter-map
            (lambda (p)
              (let* ([n (car p)]
                     [len (string-length (number->string n))]
                     [place (symbol->string (cdr p))])
                (if (not (positive? n))
                  #f
                  (cond [(and (string=? place "END") (<= len 2)) (step1 n)]
                        [(string=? place "END") (hundreds n)]
                        [(<= len 2) (string-append (step1 n) " " place)]
                        [else (string-append (hundreds n) " " place)]))))
            s3)
          " ")))))
          
(define (hundreds n)
  (define (charlist->n lst)
    (string->number (string-join (map number->string lst) "")))

  (let* ([lst (n->list n)]
         [even-hundred (string-append (vector-ref under-20 (first lst)) " hundred")])
    (match lst
      [(list a b c) (cond [(and (zero? b) (zero? c)) even-hundred]
                          [else (string-append even-hundred " " (step1 (charlist->n (rest lst))))])])))
