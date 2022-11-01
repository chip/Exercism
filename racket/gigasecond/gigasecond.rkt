#lang racket

(require racket/date)

(provide add-gigasecond)

(define (add-gigasecond datetime)
  (seconds->date (+ (expt 10 9) (date->seconds datetime))))
