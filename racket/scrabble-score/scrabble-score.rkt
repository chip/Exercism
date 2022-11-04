#lang racket

(provide score)

(require math/base)

(define (char->score byte)
  (let ([c (string byte)])
    (cond 
      [(string-contains? "AEIOULNRST" c) 1]
      [(string-contains? "DG" c) 2]
      [(string-contains? "BCMP" c) 3]
      [(string-contains? "FHVWY" c) 4]
      [(string-contains? "K" c) 5]
      [(string-contains? "JX" c) 8]
      [(string-contains? "QZ" c) 10]
      [else 0])))

(define (score word)
  (sum (map char->score (string->list (string-upcase word)))))
