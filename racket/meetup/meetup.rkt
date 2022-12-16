#lang racket

(provide meetup-day)

(require racket/date)

(define days-of-week #(Sunday Monday Tuesday Wednesday Thursday Friday Saturday))
(define teens (sequence->list (in-inclusive-range 13 19)))

(define (make-seconds year month day)
  (find-seconds 0 0 0 day month year #f))

(define (make-date year month day)
  (seconds->date (make-seconds day month year #f) #f))

(define (find-last-day year month day)
  (with-handlers ([exn:fail? (lambda (exn) #f)]) 
    (if (find-seconds 0 0 0 day month year #t)
    ;(if (make-date day month year) ; TODO REVISIT
      day
      #f)))

(define (last-day-of-month year month)
  (last
    (filter-map
      (lambda (day)
        ;(printf "try day: ~a\n" day)
        (find-last-day year month day))
      '(28 29 30 31))))

;(printf "ldom: ~a\n" (last-day-of-month 2014 2))

; Then convert 'first, 'second, etc. to analagous racket fns (SPECIAL CASE: 'teenth)
(define (get-date year month day weekday)
  (let* ([date (seconds->date (find-seconds 0 0 0 day month year #t))]
         [current-weekday (vector-ref days-of-week (date-week-day date))])
    (if (equal? current-weekday weekday)
      date
      #f)))

(define (matches-week-day date)
  (if (member (date-week-day date) teens)
    date
    #f))

(define (matching-days year month weekday week-of-month)
  (let* ([last-day (last-day-of-month year month)] ; TODO extract
         [day-range (sequence->list (in-inclusive-range 1 last-day))])
    (filter-map (lambda (day) (get-date year month day weekday)) day-range)))

(define (meetup-day year month weekday week-of-month)
  (printf "meetup-day: ~a\t~a\t~a\t~a\n" year month weekday week-of-month)
  (let ([matches (matching-days year month weekday week-of-month)])
    (printf "matches: ~a\n" matches)))
#| (check-equal? (meetup-day 2013 5 'Monday 'teenth)) |#
#| (printf "d: ~a\n" (date->string (make-date 2013 5 13))) |#
