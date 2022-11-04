#lang racket

(provide score)

(define (lookup byte)
  (let ([letter (string-upcase (string byte))])
    (cond 
      [(regexp-match? #rx"[AEIOULNRST]" letter) 1]
      [(regexp-match? #rx"[DG]" letter) 2]
      [(regexp-match? #rx"[BCMP]" letter) 3]
      [(regexp-match? #rx"[FHVWY]" letter) 4]
      [(regexp-match? #rx"[K]" letter) 5]
      [(regexp-match? #rx"[JX]" letter) 8]
      [(regexp-match? #rx"[QZ]" letter) 10]
      [else 0])))

(define (score word)
  (if (zero? (string-length word))
    0
    (for/sum ([i (map (lambda (byte) (lookup byte)) (string->list word))]) i)))
