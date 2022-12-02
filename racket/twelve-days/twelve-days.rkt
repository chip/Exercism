#lang racket

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

(define (twelve-days-range start end)
  (let loop ([lst empty]
             [current (sub1 start)])
    (let* ([on-the (format preamble (list-ref days current))]
           [line (string-join (list on-the (recite-days current)))])
      (if (= current end)
        lst
        (loop (append lst line) (add1 current))))))
        ;(string-join (list on-the (recite-days current)))))))
        ;(loop (append lst (list (list-ref lyrics current))) (add1 current))))))

(define twelve-days
  (case-lambda
    [() (twelve-days-range 1 12)]
    [(a b) (twelve-days-range a b)]))

(twelve-days 12 12)

#|     "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#
#|     "" |#
#|     "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree." |#

