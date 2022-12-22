#lang racket

;; Converts integers to English-language descriptions

;; --- NOTE -------------------------------------------------------------------
;; The test cases in "say-test.rkt" assume:
;; - Calling a function with an out-of-range argument triggers a contract error
;; - That `step3` returns a list of (number, symbol) pairs
;;
;; We have provided sample contracts so the tests compile, but you
;;  will want to edit & strengthen these.
;;
;; (For example, things like 0.333 and 7/8 pass the `number?` contract
;;  but these functions expect integers and natural numbers)
;; ----------------------------------------------------------------------------

(require racket/contract)

(define (pp label x)
  (displayln (format "*[~a] ~a" label x)))

(define/contract (two-digit-number? n)
  (exact-nonnegative-integer? . -> . boolean?)
  #| (pp "two-digit-number?" n) |#
  #| (pp "exact-nonnegative-integer?" (exact-nonnegative-integer? n)) |#
  #| (pp "length" (<= (string-length (number->string n)) 2)) |#
  (<= (string-length (number->string n)) 2))

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
(define under-20 (vector "zero" "one" "two" "three" "four" "five" "six" "seven"
                         "eight" "nine" "ten" "eleven" "twelve" "thirteen"
                         "fourteen" "fifteen" "sixteen" "seventeen" "eighteen"
                         "nineteen"))

(define tens (vector "ZERO" "TEN" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))

(define (charlist->n lst)
  ;(displayln (format "[charlist->num] ~a\n" lst))
  (string->number (string-join (map string lst) "")))

(define (char->n c)
  (string->number (string c)))

(define (step1 n)
  #| (displayln (format "step1 n: ~a\n" n)) |#
  ; TODO enforce contract for 2-digit-number? to remove conditional
  (cond [(< n 20) (vector-ref under-20 n)]
        [else
          (let ([lst (string->list (number->string n))])
            ;(displayln (format "lst: ~a\n" lst))
            (match lst
              [(list a b) (cond [(zero? (char->n b)) (vector-ref tens (char->n a))]
                                [else (string-append (vector-ref tens (char->n a)) "-" (step1 (char->n b)))])]
              [(list a) (vector-ref under-20 n)]))]))

;(step1 -1) ; SHOULD throw
;(step1 100) ; SHOULD throw

;(step1 700)
#| (conv 14) ; becomes "fourteen". |#
#| (conv 100) ; becomes "one hundred". |#
#| (conv 120) ; becomes "one hundred and twenty". |#
#| (conv 1002) ; becomes "one thousand and two". TODO Handle n w/ 3 or more digits |#
#| (conv 1323) ; becomes "one thousand three hundred and twenty-three". TODO see above |#
#| (conv 1234567890) ; should yield `'1 billion 234 million 567 thousand 890'` TODO see above |#
#| (conv 12345); should give `twelve thousand three hundred forty-five`. TODO see above |#
(define (step2 N)
  (define (pos lst)
    ;(displayln (format "length: ~a\tpos: ~a\n" (length lst) (min (length lst) 3)))
    (min (length lst) 3))

  (define (list->number lst)
    ;(displayln (format "list->number ~a\n" lst))
    (if (empty? lst)
      #f
      (string->number (string-join (map number->string (take-right lst (pos lst))) ""))))

  (let loop ([lst (filter number? (map string->number (regexp-split #rx"" (number->string N))))]
             [acc '()])
    (let* ([len (length lst)]
           [num (list->number lst)])
      ;(displayln (format "lst ~a\tacc ~a\tlen ~a\tnum ~a\n" lst acc len num))
      (if (empty? lst)
        acc
        (loop (drop-right lst (pos lst)) (append (list num) acc))))))


(define (step3 n)
  (let ([lst (step2 n)])
    ;(displayln (format "step3 lst: ~a\n" lst))
    (match lst
      [(list b m t h) (list (cons b 'billion) (cons m 'million) (cons t 'thousand) (cons h 'END))]
      [(list   m t h) (list (cons m 'million) (cons t 'thousand) (cons h 'END))]
      [(list     t h) (list (cons t 'thousand) (cons h 'END))]
      [(list       h) (list (cons h 'END))])))

(define (n-join lst)
  (string-join (map number->string lst)) "")

(define (num->word n)
  (let ([len (string-length (number->string n))])
    (if (<= len 2)
      (step1 n)
      (hundredz n))))

(define (build-str p)
  ;(pp "build-str p" p)
  (let* ([num (car p)]
         [num-str (number->string num)]
         [num-len (string-length num-str)]
         [place (symbol->string (cdr p))])
    #| (pp "build-str num-str" num-str) |#
    #| (pp "build-str place" place) |#
    (if (> num 0)
      (cond [(string=? place "END") (num->word num)]
            [(<= num-len 2) (string-append (step1 num) " " place)]
            [else (string-append (hundredz num) " " place)])
      #f)))
  
(define (step4 N)
  (if (zero? N)
    "zero"
    ;(displayln (format "step4 calling ~a" N))
    (let ([len (string-length (number->string N))]
          [s3 (step3 N)])
      (pp "here" s3)
      (if (negative? N)
        (string-append "negative " (string-join (filter-map build-str s3) " "))
        (string-join (filter-map build-str s3) " ")))))
          
(define (even-hundred lst)
  (match lst
    [(list a b c) (string-append (vector-ref under-20 (char->n (first lst))) " hundred")]))

(define (other-hundred lst)
  (string-append (vector-ref under-20 (char->n (first lst))) " hundred " (step1 (charlist->n (rest lst)))))

(define (hundredz n)
  (let ([lst (string->list (number->string n))])
    ;(pp "hundredz len" (length lst))
    ;(string-append (vector-ref tens (char->n (first lst)) " hundred " (step1 (charlist->n (rest lst)))))
    (match lst
      [(list a b c) (cond
                      [(and (zero? (char->n b)) (zero? (char->n c))) (even-hundred lst)]
                      [else (other-hundred lst)])])))

; (if (negative? (char->n a)) "negative " "") 
