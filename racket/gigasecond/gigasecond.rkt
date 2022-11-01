#lang racket

(provide add-gigasecond)

(require racket/date)

(define gigasecond 1000000000)

(define (add-gigasecond datetime)
  (seconds->date (+ gigasecond (date->seconds datetime))))
