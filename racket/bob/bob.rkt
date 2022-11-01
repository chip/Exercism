#lang racket

(provide response-for)

(define (response-for prompt)
  (cond 
    [(regexp-match #rx"^[ ]*$" prompt) "Fine. Be that way!"]
    [(regexp-match #rx"^[0-9 ,]+$" prompt) "Whatever."]
    [(regexp-match #rx"^[A-Z0-9 %^*@#$(),!]+!?$" prompt) "Whoa, chill out!"]
    [(regexp-match #rx"^[A-Z ]+\\?$" prompt) "Calm down, I know what I'm doing!"]
    [(regexp-match #rx"\\?$" prompt) "Sure."]
    [else "Whatever."]))
