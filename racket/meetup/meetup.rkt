#lang racket

(provide meetup-day)

(require racket/date)

#| (define seconds-per-minute 60) |#
#| (define minutes-per-hour 60) |#
#| (define hours-per-day 24) |#
#| (define seconds-per-day (* seconds-per-minute minutes-per-hour hours-per-day)) |#
#| (define days-per-week 7) |#
#||#
(define (meetup-day year month weekday week-of-month)
  (error 'not-implemented))
#|   (let loop ([day 1] ))|#
#|              [current-month month] |#
#|     (let* ([seconds (find-seconds 0 0 0 day current-month year #t)])) |#
#|            [current-date (seconds->date seconds)] |#
#|       (when (eq? current-month (date-month current-date))) |#
#|         (printf "~a\n" (date->string current-date)) |#
#|         (loop (add1 day) current-month) |#
#|     day |#
#||#
;(meetup-day 2013 5 'Monday 'teenth) |#
; (with-handlers ([exn:fail:contract:divide-by-zero? (lambda (exn) +inf.0)]) (/ 1 0))

(define (___find-last-day year month day)
  (let ([date (seconds->date (find-seconds 0 0 0 day month year #t))])
    (printf "DATE: ~a\tday: ~a\tmonth: ~a\tcurrent-month: ~a\n" (date->string date) day month (date-month date))
    (when (eq? month (date-month date))
      day)))

(define (find-last-day year month day)
  (with-handlers ([exn:fail? (lambda (exn) #f)]) 
    (if (find-seconds 0 0 0 day month year #t)
      day
      #f)))

;(find-last-day 2023 2 31)
(define (last-day-of-month year month)
  (last
    (filter-map
      (lambda (day)
        ;(printf "try day: ~a\n" day)
        (find-last-day year month day))
      '(28 29 30 31))))

(printf "ldom: ~a\n" (last-day-of-month 2014 2))

;(let ([day 31]
;      [month 2]
;      [year 2023]
;  (find-seconds 0 0 0 day month year #t))


;(find-seconds 0 0 0 31 2 2023 #t)
;; Given a day, month, and year, return the weekday
#|   (define (day-month-year->weekday day month year)) |#
#|     (define local-secs (find-seconds 0)) |#
#|                                      0 |#
#|                                      0 |#
#|                                      day |#
#|                                      month |#
#|                                      year |#
#|                                      #t |#
#|     (define the-date (seconds->date local-secs)) |#
#|     (vector-ref #("sunday" "monday" "tuesday" "wednesday" "thursday")) |#
#|                            "friday" "saturday" |#
#|                 (date-week-day the-date) |#
#| > (day-month-year->weekday 15 12 2022) |#
#| "thursday" |#
#| > (define s (find-seconds 0 0 0 16 12 2022 #t)) |#
#| > (define d (seconds->date s)) |#
#| > (date-week-day d) |#
#| (check-equal? (meetup-day 2013 5 'Monday 'teenth)) |#
#|              (make-date 2013 5 13) |#
