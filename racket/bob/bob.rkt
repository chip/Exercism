#lang racket

(provide response-for)

(define (silence? prompt)
  (regexp-match #rx"^[ ]*$" prompt))

(define (shouting? prompt)
  (regexp-match #rx"^[A-Z0-9 %^*@#$(),!]+!?$" prompt))

(define (shouting-question? prompt)
  (regexp-match #rx"^[A-Z ]+\\?$" prompt))

(define (question? prompt)
  (regexp-match #rx"\\?$" prompt))

(define (only-numbers? prompt)
  (regexp-match #rx"^[0-9 ,]+$" prompt))

(define (response-for prompt)
  (cond 
    [(silence? prompt) "Fine. Be that way!"]
    [(only-numbers? prompt) "Whatever."]
    [(shouting? prompt) "Whoa, chill out!"]
    [(shouting-question? prompt) "Calm down, I know what I'm doing!"]
    [(question? prompt) "Sure."]
    [else "Whatever."]))
