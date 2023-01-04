#lang racket

(provide encode decode)

(define (reverse-string s)
  (list->string (reverse (string->list s))))

(define (every-7-digits s)
  (let loop ([acc '()]
             [chars (reverse-string s)])
    (if (> (string-length chars) 7)
      (loop (cons (reverse-string (substring chars 0 7)) acc) (substring chars 7 (string-length chars)))
      (cons (reverse-string chars) acc))))

(define (padded-binary-string n)
  (~r n #:base 2 #:min-width 8 #:pad-string "0"))

(define (set-continuation-bit s setbit)
  (let ([bs (padded-binary-string (string->number s 2))])
    (when setbit
      (string-set! bs 0 #\1))
    bs))

(define (convert-list-of-strings acc)
  (map (lambda (x) (string->number (~r (string->number x)) 2)) acc))

;;; Both of these should expect to take a variable number of arguments.
;;; You may wish to make a version that accepts a single argument first
;;; as that will make debugging easier.
(define (encode . nums)
  (for/fold ([memo '()])
            ([n (in-list nums)])
    (if (< n 128)
      (append memo (list n))
      (let ([lst (every-7-digits (padded-binary-string n))])
        (for/fold ([acc '()]
                   [remaining lst]
                   #:result (append memo (convert-list-of-strings acc)))
                  ([bs (in-list lst)])
          (let ([setbit (> (length remaining) 1)])
            (values (append acc (list (set-continuation-bit bs setbit))) (rest remaining))))))))

(define (convert memo)
  (printf "memo: ~a\n" memo)
  (printf "memo string-join: ~a\n" (string-join memo ""))
  (printf "memo string-number ~a\n" (string->number (string-join memo "") 2))
  (list (string->number (string-join memo "") 2)))

;;; TODO for each num: convert to binary string, remove continuation bit, join, convert to decimal
(define (decode . nums)
  (when (and (= 1 (length nums)) (>= (first nums) 128))
    (error 'incomplete-sequence))
  (for/fold ([memo '()]
             #:result (convert memo))
            ([n (in-list nums)])
    (let ([bs (padded-binary-string n)])
      (printf "n ~a bs ~a\n" n bs)
      ;(printf "substring ~a\n" (substring bs 1 8))
      ;(string-set! bs 0 #\0)
      (values (append memo (list (substring bs 1 8)))))))

