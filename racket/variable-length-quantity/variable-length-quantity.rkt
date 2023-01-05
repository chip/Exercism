#lang racket

(provide encode decode)

(define (reverse-string s)
  (list->string (reverse (string->list s))))

(define (split-at-x-chars x s)
  (let loop ([acc '()]
             [chars (reverse-string s)])
    (if (> (string-length chars) x)
      (loop (cons (reverse-string (substring chars 0 x)) acc) (substring chars x (string-length chars)))
      (cons (reverse-string chars) acc))))

(define (padded-binary-string n)
  (~r n #:base 2 #:min-width 8 #:pad-string "0"))

(define (set-continuation-bit s setbit)
  (let ([bs (padded-binary-string (string->number s 2))])
    (when setbit
      (string-set! bs 0 #\1))
    bs))

(define (los->encode acc)
  (map (lambda (x) (string->number (~r (string->number x)) 2)) acc))

(define (encode . nums)
  (for/fold ([memo '()])
            ([n (in-list nums)])
    (if (< n 128)
      (append memo (list n))
      (let ([lst (split-at-x-chars 7 (padded-binary-string n))])
        (for/fold ([acc '()]
                   [remaining lst]
                   #:result (append memo (los->encode acc)))
                  ([bs (in-list lst)])
          (let ([setbit (> (length remaining) 1)])
            (values (append acc (list (set-continuation-bit bs setbit))) (rest remaining))))))))

(define (decode . nums)
  (when (and (= 1 (length nums)) (>= (first nums) 128))
    (error 'incomplete-sequence))
  (for/fold ([buf ""]
             [memo '()]
             #:result (map (lambda (x) (string->number x 2)) memo))
            ([n (in-list nums)])
    (let* ([bs (padded-binary-string n)]
           [bits (substring bs 1 8)])
      (if (regexp-match? #rx"^1" bs)
        (values (string-append buf bits) memo)
        (values "" (append memo (list (string-append buf bits))))))))
