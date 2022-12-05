#lang debug racket

(provide twelve-days)

(define lyrics
  (list
    "a Partridge in a Pear Tree."
    "two Turtle Doves"
    "three French Hens"
    "four Calling Birds"
    "five Gold Rings"
    "six Geese-a-Laying"
    "seven Swans-a-Swimming"
    "eight Maids-a-Milking"
    "nine Ladies Dancing"
    "ten Lords-a-Leaping"
    "eleven Pipers Piping"
    "twelve Drummers Drumming"))

(define days (list 'first 'second 'third 'fourth 'fifth 'sixth 'seventh 'eighth
                   'ninth 'tenth 'eleventh 'twelfth))

(define (recite-days n)
  (string-join (reverse (take lyrics n)) ", " #:before-last ", and "))

(define (on-the-day i)
  (format "On the ~a day of Christmas my true love gave to me:" (list-ref days i)))

(define (phrase-of-day i)
  (string-append (on-the-day i) " " (recite-days (add1 i))))

(define (join-phrase s i)
  (string-trim (string-append s "\n\n" (phrase-of-day i)) #:right? #t))

(define (twelve-days-range start end)
  (let loop ([s ""]
             [i (sub1 start)])
    (if (= i end)
      s
      (loop (join-phrase s i) (add1 i)))))

(define twelve-days
  (case-lambda
    [() (twelve-days-range 1 12)]
    [(a b) (twelve-days-range a b)]))
