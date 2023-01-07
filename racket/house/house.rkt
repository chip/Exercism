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
  (define (postmodifier i)
    (list-ref postmodifiers (- (length postmodifiers) i)))

  (define (determiner i curr)
    (if (= i curr)
      (list-ref determiners 0)
      (list-ref determiners (- (length determiners) i))))

  (define (noun-phrases phrases#)
    (for/fold ([phraselst '()]
               #:result (list (string-join phraselst "\n")))
              ([i (range phrases# 0 -1)])
      (append phraselst (list (string-append (determiner i phrases#) " " (postmodifier i))))))

  (let loop ([grouplst '()]
             [i start])
    (if (> i (length postmodifiers))
      (string-join grouplst "\n\n")
      (let ([phraselst (noun-phrases i)])
        (if (> i end) 
          (string-join grouplst "\n\n")
          (loop (append grouplst phraselst) (add1 i)))))))
