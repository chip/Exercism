#lang racket

(provide encode decode)

(define (reverse-string s)
  (list->string (reverse (string->list s))))

(define (every-7-s s)
  (let loop ([acc '()]
             [chars (reverse-string s)])
    ;(displayln (format "acc: ~v\nchars: ~v\n" acc chars))
    ;(displayln (format "chars: ~a\tlength: ~a" chars (length chars)))
    (if (> (string-length chars) 7)
      (loop (cons (reverse-string (substring chars 0 7)) acc) (substring chars 7 (string-length chars)))
      (cons (reverse-string chars) acc))))

(define (set-continuation-bit s setbit)
  ;(printf "set-continuation-bit ~a\n" s)
  ;(printf "string->number ~a\n" (string->number s 2))
  ;(let ([bs (~r (string->number s) #:base 2 #:min-width 8 #:pad-string "0")]))
  (let ([bs (~r (string->number s 2) #:base 2 #:min-width 8 #:pad-string "0")])
    ;(printf "bs ~a\n" bs)
    (when setbit
      (string-set! bs 0 #\1))
    bs))

(define (convert-los acc)
  (printf "convert-los acc ~a\n" acc)
  (let ([mm (map
              (lambda (x)
                (string->number (~r (string->number x)) 2)) acc)])
    (printf "mm: ~a\n" mm)
    mm))

;;; Both of these should expect to take a variable number of arguments.
;;; You may wish to make a version that accepts a single argument first
;;; as that will make debugging easier.
(define (encode . nums)
  ;(printf "nums: ~a\n" nums)
  (for/fold ([memo '()])
            ([n (in-list nums)])
    ;(printf "n: ~a\n" n)
    ;(printf "memo: ~a\n" memo)
    (if (< n 128)
      (append memo (list n))
      (let ([lobs (every-7-s (d->b n))])
        ;(printf "lobs ~a\n" lobs)
        (for/fold ([acc '()]
                   [lst lobs]
                   #:result (append memo (convert-los acc)))
                  ([bs (in-list lobs)])
          ;(printf "lobs: ~a\n" lobs)
          ;(printf "lst ~a\n" lst)
          ;(printf "bs ~a\n" bs)
          (let ([setbit (> (length lst) 1)])
            (values (append acc (list (set-continuation-bit bs setbit))) (rest lst))))))))

(define (pp s n)
  (displayln (format "~a: ~v" s n)))

(define (decode . nums)
  (error "Not implemented yet"))

(define (d->b x)
  (~r x #:base 2 #:pad-string "0" #:min-width 8))
