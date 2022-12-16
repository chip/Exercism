#lang racket

(provide meetup-day)

(require racket/date)

(define days-of-week #(Sunday Monday Tuesday Wednesday Thursday Friday Saturday))
(define teens (sequence->list (in-inclusive-range 13 19)))

(define (find-last-day year month day)
  (with-handlers ([exn:fail? (lambda (exn) #f)]) 
    (if (find-seconds 0 0 0 day month year #t)
      day
      #f)))

(define (last-day-of-month year month)
  (last
    (filter-map
      (lambda (day) (find-last-day year month day))
      '(28 29 30 31))))

(define (get-date year month day weekday)
  (let* ([date (seconds->date (find-seconds 0 0 0 day month year #f) #f)]
         [current-weekday (vector-ref days-of-week (date-week-day date))])
    (if (equal? current-weekday weekday)
      date
      #f)))

(define (teenth-date? date)
  (if (member (date-day date) teens)
    date
    #f))

(define (day-range year month)
  (sequence->list (in-inclusive-range 1 (last-day-of-month year month))))

(define (matching-days year month weekday week-of-month)
  (filter-map (lambda (day) (get-date year month day weekday)) (day-range year month)))

(define (find-teenth matching-dates)
  (first (filter-map teenth-date? matching-dates)))

(define (find-match matches fn)
  (cond [(equal? fn 'first) (first matches)]
        [(equal? fn 'second) (second matches)]
        [(equal? fn 'third) (third matches)]
        [(equal? fn 'fourth) (fourth matches)]
        [else (last matches)]))

(define (meetup-day year month weekday week-of-month)
  (let ([matches (matching-days year month weekday week-of-month)])
    (cond [(equal? week-of-month 'teenth) (find-teenth matches)]
          [(find-match matches week-of-month)])))
