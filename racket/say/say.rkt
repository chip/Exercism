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

(provide
  (contract-out
    [step1 (-> number? string?)]
    ;; Convert a positive, 2-digit number to an English string

    [step2 (-> number? (listof number?))]
    ;; Divide a large positive number into a list of 3-digit (or smaller) chunks

    [step3 (-> number? (listof (cons/c number? symbol?)))]
    ;; Break a number into chunks and insert scales between the chunks

    [step4 (-> number? string?)]))
    ;; Convert a number to an English-language string


;; =============================================================================
(define under-20 (vector "zero" "one" "two" "three" "four" "five" "six" "seven"
                         "eight" "nine" "ten" "eleven" "twelve" "thirteen"
                         "fourteen" "fifteen" "sixteen" "seventeen" "eighteen"
                         "nineteen"))

(define tens (vector "ZERO" "TEN" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))

(define (convert n)
  (if (= 0 n)
    ""
    (begin
      ;(displayln (format "[convert 1] n ~a\n" n))
      (let ([lst (map string->number (map string (string->list (number->string n))))])
        ;(displayln (format "[convert 2] lst: ~a\tpair? ~a\n" lst (pair? lst)))
        (let ([x (first lst)]
              [y (last lst)])
          ;(displayln (format "[convert 3] lst: ~a\tx: ~a\ty: ~a\n" lst x y))
          (if (> y 0)
            (string-append (vector-ref tens x) "-" (vector-ref under-20 y))
            (string-append (vector-ref tens x))))))))

(define (convert-3-digits n)
  (let ([s (number->string n)])
    (string-trim
      (string-append
        (vector-ref under-20 (string->number (substring s 0 1)))
        " hundred "
        (if (> n 100)
          (step1 (string->number (substring s 1 (string-length s))))
          "")))))

(define (step1 n)
  ;(displayln (format "step1 n: ~a\n" n))
  (let* ([s (number->string n)]
         [len (string-length s)])
    ;(displayln (format "[step1] n ~a\ts: ~a\tlen: ~a\n" n s len))
    (cond [(< n 20) (vector-ref under-20 n)]
          [(<= len 2) (convert n)]
          [(= len 3) (convert-3-digits n)]
          [(<= len 6) (string-trim (string-append (vector-ref under-20 (string->number (substring s 0 2))) " thousand " (convert (string->number (substring s 2 len)))))]
          [(<= len 9) (string-trim (string-append (vector-ref under-20 (string->number (substring s 0 2))) " million " (convert (string->number (substring s 2 len)))))]
          [(<= len 12) (string-trim (string-append (vector-ref under-20 (string->number (substring s 0 2))) " billion " (convert (string->number (substring s 2 len)))))]
          [(<= len 15) (string-trim (string-append (vector-ref under-20 (string->number (substring s 0 2))) " trillion " (convert (string->number (substring s 2 len)))))]
          [else (error exn:fail:contract:continuation)])))

(define (pos lst)
  ;(displayln (format "length: ~a\tpos: ~a\n" (length lst) (min (length lst) 3)))
  (min (length lst) 3))

(define (list->number lst)
  ;(displayln (format "list->number ~a\n" lst))
  (if (empty? lst)
    #f
    (string->number (string-join (map number->string (take-right lst (pos lst))) ""))))

(define (step2 N)
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
      [(list a b c d) (list (cons a 'billion)  (cons b 'million)  (cons c 'thousand) (cons d 'END))]
      [(list a b c)   (list (cons a 'million)  (cons b 'thousand) (cons c 'END))]
      [(list a b)     (list (cons a 'thousand) (cons b 'END))]
      [(list a)       (list (cons a 'END))]))) 

(define (step4 N)
  (step1 N))
  ;(let ([lst (step3 N)])
  ;  (displayln (format "step4 N ~a\tlst ~a\n" N lst))
  ;  #| (map |#)
  ;  #|   (lambda (p) |#)
  ;  #|     (cons (step1 (first p)) (cdr p))) |#
  ;  #|   lst) |#
  ;  ;(step1 N)))
