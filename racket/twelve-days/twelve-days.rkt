#lang debug racket

(provide twelve-days)

(define preamble "On the ~a day of Christmas my true love gave to me:")

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

(define days (list 'first 'second 'third 'fourth 'fifth 'sixth 'seventh 'eighth 'ninth 'tenth 'eleventh 'twelfth))

(define (recite-days n)
  (string-join (reverse (take lyrics n))
               ", "
               #:before-last ", and "))

(define (on-the index)
  (format preamble (list-ref days index)))

(define (join lst)
  (displayln (format "lst:"))
  (displayln (list->string lst))
  (string-join lst))

(define (twelve-days-range start end)
  (let loop ([lst empty]
             [current (sub1 start)])
    #| (displayln (format "lst: ~a | current: ~a | end: ~a" lst current end)) |#
    (if (= current end)
      (join lst)
      (let ([on-the-phrase (on-the current)]
            [ordered-phrases (recite-days (add1 current))])
        #| (displayln (format "ordered-phrases: ~a |" ordered-phrases)) |#
        #| (displayln (format "on-the-phrase: ~a |" on-the-phrase)) |#
        (loop (append lst (list on-the-phrase ordered-phrases) (list "\n\n"))
              (add1 current))))))

(define twelve-days
  (case-lambda
    [() (twelve-days-range 1 12)]
    [(a b) (twelve-days-range a b)]))

(twelve-days)
;(recite-days 3)
