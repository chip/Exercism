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

(define (set-continuation-bit s)
  ;(printf "set-continuation-bit ~a\n" s)
  ;(printf "string->number ~a\n" (string->number s 2))
  ;(let ([bs (~r (string->number s) #:base 2 #:min-width 8 #:pad-string "0")]))
  (let ([bs (~r (string->number s 2) #:base 2 #:min-width 8 #:pad-string "0")])
    ;(printf "bs ~a\n" bs)
    (string-set! bs 0 #\1)
    bs))

;;; Both of these should expect to take a variable number of arguments.
;;; You may wish to make a version that accepts a single argument first
;;; as that will make debugging easier.
(define (encode . nums)
  ;(error "Not implemented yet"))
  (printf "nums: ~a\n" nums)
  ; TODO need loop for nums
  ; TODO need second loop for every-7 ???
  (let* ([n (first nums)]
         [binlist (every-7-s (d->b n))])
    ;(printf "n ~a\n" n)
    ;(printf "binlist ~a list? ~a\n" binlist (list? binlist))
    (if (< n 128)
      (list n)
      (let loop ([acc '()]
                 [lst binlist])
        ;(printf "acc ~a\n" acc)
        ;(printf "lst: ~a\n" lst)
        ;(printf "first lst: ~a\n" (first lst))
        ; TODO set high-order bit for loop
        (let ([curr (set-continuation-bit (first lst))])
          ;(printf "curr: ~a\n" curr)
          ;(printf "(list curr): ~a\n" (list curr))
          (if (= (length lst) 1)
            (begin
              ;(printf "string? ~a\n" (string? curr))
              (let ([los (append acc (list (first lst)))])
                ;(printf "los ~a list? ~a pair? ~a\n" los (list? los) (pair? los))
                (map (lambda (x) (string->number (~r (string->number x) #:base 10) 2)) los)))
            (loop (append acc (list curr)) (rest lst))))))))

(define (old_encode . nums)
  ;(error "Not implemented yet"))
  (printf "nums: ~a\n" nums)
  ; TODO need loop for nums
  ; TODO need second loop for every-7 ???
  (let* ([n (first nums)]
         [binlist (every-7 (string->list (d->b n)))])
    (let loop ([acc '()]
               [lst binlist])
      (printf "lst: ~a\n" lst)
      ; TODO set high-order bit for loop
      (let ([curr (string->number (first lst))])
        (if (= (length lst) 1)
          (append acc curr)
          (loop (append acc curr) (rest lst)))))))
       
#| (string->number "101" 2) |#
#| (number->string 128 2) |#
;(define (every-7 lst)
;  (let ([cnt 0])
;    (displayln (format "every-7: ~a\t~a\n" lst (list? lst)))
;    (for ([i lst])
;      (set! cnt (add1 cnt))
;      ;(displayln (format "cnt ~a\n" cnt))
;      (if (zero? (modulo cnt 7))
;        i
;        #f)))

;(let ([e7 (every-7 (range 14))])
;  (displayln (format "e7: ~a\n" e7)))
;
;(define x 128)
;(~r (string-append "#b" (number->string x)))
;(displayln (~r #b111011))

;(append '() (list (take (range 24) 7)))
;(define my-lst '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))

;(drop '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) 8)
;(take '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) 8)
;(list-tail '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) 8)
;(drop my-lst 4)

;(let ([e7 (every-7 '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))])
;  (displayln (format "--> ~a\n" e7)))

(define (en n)
  (displayln (format "s ~a" (number->string n 2)))
  (displayln (format "lst ~a" (string->list (number->string n 2))))
  ;(displayln (format "split ~a ~a" (split-at (string->list (number->string n 2)) 7)))
  ;(displayln (format "chars ~a" (take (string->list (number->string n 2)) 7)))
  (displayln (format "partition ~a" (partition every-7 (string->list (number->string n 2))))))

;(define x "10000000")
;(~r (string->number (string-append "#b" x)) #:base 2)
;(displayln (format "~a" (string-append "~b" (number->string x))))
;(define x 128)
;(en 8192)
;(~r (string->number (string-append "#b" (number->string x)) #:base 10))
;(format "~b" (+ #b001 #b110))
;(format "~x" x)

(define (enc n)
  (let loop ([byte (bitwise-and n 127)]
             [number (arithmetic-shift n -7)])
    (displayln (format "byte: ~x\tbyte: ~a\tnumber: ~a" byte byte number))
    (if (zero? number)
      (displayln (format "END: ~x\t~a\t~x\t~a" byte byte number number))
      (begin
        (let ([byte (+ byte 128)])
          ;(displayln (format "bloc byte: ~x\tbyte ~a\tnumber: ~a" byte byte number))
          (loop (bitwise-and 127 number) (arithmetic-shift number -7)))))))

;(enc x)
;(define ls '(a b c d e f))
;(displayln (reverse (rest (reverse ls))))

;(define num 128)
;(define bar
;  (let* ([e7 (every-7 (string->list (number->string 128 2)))]
;         [f (first e7)]
;         [fs (list->string f)]
;         [fn (string->number fs)]
;         [sa (number->string fn)])
;    (displayln (format "e7: ~a" e7))
;    (displayln (format "f: ~a" f))
;    (displayln (format "fs: ~a" fs))
;    (displayln (format "fn: ~a" fn))
;    (displayln (format "sa ~a" sa))))
;    ;(displayln (format "pad: ~a" (~r sa #:base 2 #:pad-string "0" #:min-width 8))))


; TODO send optional arg 
; TODO set default arg
(define (binary->decimal b)
  (let* ([s (list->string b)]
         [n (string->number s)]
         [nf (~r n #:base 2 #:pad-string "0" #:min-width 8)])
    (displayln (format "b: ~a\ts: ~a\tn: ~a\tnf: ~a" b s n nf))
    nf))

(define (add-continuation-bit s)
  (let ([ns (string-append "1" s)])
    (displayln (format "add-continuation-bit ns: ~a" ns))
    ns))

(define (pp s n)
  (displayln (format "~a: ~v" s n)))
;(define n 128))
(define (foo n)
  (let* ([s (number->string n 2)]
         [bs (~r n #:base 2 #:pad-string "0" #:min-width 8)]
         [e7 (every-7 (string->list bs))]
         [f (first e7)]
         [fl (string->number (string-append "1" (list->string f)))]
         [fs (~r fl #:pad-string "0" #:min-width 8)]
         [fsn (string->number fs)]
         [l (last e7)]
         ;[start (string->number (string-append "#b" (add-continuation-bit (binary->decimal (string->number (list->string (first e7)))))))]
         [start (string->number (string-append "#b" fs))])
         ;[end (string->number (string-append "#b" (binary->decimal (last e7))))])
      (pp "n" n)
      (pp "s" s)
      (pp "bs" bs)
      (pp "e7" e7)
      (pp "f" f)
      (pp "fl" fl)
      (pp "fs" fs)
      (pp "fsn" fsn)
      (pp "l" l)
      (pp "start" start)
      (pp "debug" (f))))
      ;(displayln (format "end: ~a" end))
      ;(list start end))))

;(foo 128)

(define (decode . nums)
  (error "Not implemented yet"))

; 128 | 128
;     | 1   R0

; 128 | 8192
;     | 64   R0

(define zzz 71397)
;(define zzz 8192)
(define (d->b x)
  (~r x #:base 2 #:pad-string "0" #:min-width 8))
;(pp "d->b" (d->b zzz))
;(pp "string->list" (string->list (d->b zzz)))
;(pp "reverse" (reverse (string->list (d->b zzz))))
;(pp "take" (reverse (take (reverse (string->list (d->b zzz))) 7)))
;(pp "list->string" (list->string (reverse (take (reverse (string->list (d->b zzz))) 7))))
;(pp "string->number" (string->number (list->string (reverse (take (reverse (string->list (d->b zzz))) 7))) 2))
;(pp "arithmetic-shift" (arithmetic-shift (string->number (d->b zzz) 2) -7))
;(pp "arithmetic-shift d->b" (d->b (arithmetic-shift (string->number (d->b zzz) 2) -7)))
;(pp "arithmetic-shift d->b" (d->b (arithmetic-shift (string->number (d->b zzz) 2) -7)))

(define (every-7 lst)
  (let loop ([acc '()]
             [chars (reverse lst)])
    (displayln (format "acc: ~v\nchars: ~v\n" acc chars))
    ;(displayln (format "chars: ~a\tlength: ~a" chars (length chars)))
    (if (> (length chars) 7)
      (loop (cons (reverse (take chars 7)) acc) (drop chars 7))
      (cons (reverse chars) acc))))

;(every-7 '(#\1 #\0 #\0 #\0 #\0 #\0 #\0 #\0))
;(take (reverse '(a b c d e f g h i j k l m n o p q r s t u v w x y z)) 7)
;(drop (reverse '(a b c d e f g h i j k l m n o p q r s t u v w x y z)) 7)

;(every-7 '(a b c d e f g h i j k l m n o p q r s t u v w x y z))
;(define x 128)
;(d->b 128)
;(string->list (d->b 128))
;(every-7 (string->list (d->b 128)))

;                 '('(a b c d e) '(f g h i j k l) '(m n o p q r s) '(t u v w x y z)))
