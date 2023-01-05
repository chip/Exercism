#lang racket

(provide house)

(define determiners '("This is the"
                      "that belonged to the"
                      "that kept the"
                      "that woke the"
                      "that married the"
                      "that kissed the"
                      "that milked the"
                      "that tossed the"
                      "that worried the"
                      "that killed the"
                      "that ate the"
                      "that lay in the"))

(define postmodifiers '("horse and the hound and the horn"
                        "farmer sowing his corn"
                        "rooster that crowed in the morn"
                        "priest all shaven and shorn"
                        "man all tattered and torn"
                        "maiden all forlorn"
                        "cow with the crumpled horn"
                        "dog"
                        "cat"
                        "rat"
                        "malt"
                        "house that Jack built."))

(define (house [start 1] [end 12])
  ; TODO remove?
  (define (determiner-index i)
    (- (length determiners) i))

  ; TODO remove?
  (define (postmodifier-index i)
    (- (length postmodifiers) i))

  (define (postmodifier i)
    (list-ref postmodifiers (postmodifier-index i)))

  (define (determiner i)
    ;(displayln (format "determiner i: ~a start: ~a" i start))
    (if (= i start)
      (list-ref determiners 0)
      (list-ref determiners (determiner-index i))))

  ;(displayln (format "start: ~a end: ~a\n" start end))
  (let loop ([i start]
             [acc '()])
    ;(displayln (format "i: ~a acc: ~a\n" i acc))
    (if (= (length acc) end)
      (string-join acc "\n")
      (loop (sub1 i) (append acc (list (string-append (determiner i) " " (postmodifier i))))))))

#| (define phrases '("This is the horse and the hound and the horn")) |#
#|                   "that belonged to the farmer sowing his corn" |#
#|                   "that kept the rooster that crowed in the morn" |#
#|                   "that woke the priest all shaven and shorn" |#
#|                   "that married the man all tattered and torn" |#
#|                   "that kissed the maiden all forlorn" |#
#|                   "that milked the cow with the crumpled horn" |#
#|                   "that tossed the dog" |#
#|                   "that worried the cat" |#
#|                   "that killed the rat" |#
#|                   "that ate the malt" |#
#|                   "that lay in the house that Jack built." |#
