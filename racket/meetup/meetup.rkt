#lang racket

(provide meetup-day)

(require racket/date)

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
  (define days-of-week #(Sunday Monday Tuesday Wednesday Thursday Friday Saturday))
  (let* ([date (seconds->date (find-seconds 0 0 0 day month year #f) #f)]
         [current-weekday (vector-ref days-of-week (date-week-day date))])
    (if (equal? current-weekday weekday)
      date
      #f)))

(define (teenth-date? date)
  (define teens (sequence->list (in-inclusive-range 13 19)))
  (if (member (date-day date) teens)
    date
    #f))

(define (day-range year month)
  (sequence->list (in-inclusive-range 1 (last-day-of-month year month))))

(define (meetup-day year month weekday week-of-month)
  (let ([matches (filter-map (lambda (day) (get-date year month day weekday)) (day-range year month))])
    (cond [(equal? week-of-month 'teenth) (first (filter-map teenth-date? matches))]
          [(equal? week-of-month 'first) (first matches)]
          [(equal? week-of-month 'second) (second matches)]
          [(equal? week-of-month 'third) (third matches)]
          [(equal? week-of-month 'fourth) (fourth matches)]
          [else (last matches)])))
