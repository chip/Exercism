#lang racket

(provide two-fer)

(define two-fer
  (case-lambda
    [() (two-fer "you")]
    [(name) (string-append "One for " name ", one for me.")]))
