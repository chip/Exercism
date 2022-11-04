#lang racket

(provide isogram?)

(define (special-char? byte)
  (not (member byte '(#\space #\-))))
       
(define (isogram? word)
  (let ([letters (filter special-char? (string->list (string-downcase word)))])
    (= (length letters) (length (remove-duplicates letters)))))
