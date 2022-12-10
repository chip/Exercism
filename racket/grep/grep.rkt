#lang racket

(provide grep)

(define (grep flags pattern files)

  (define (show-line-numbers? flags)
    (member "-n" flags))
  
  (define (case-insensitive? flags)
    (member "-i" flags))

  (define (match-line? flags)
    (member "-x" flags))

  (define (invert-match? flags)
    (member "-v" flags))

  (define (show-filename? flags)
    (member "-l" flags))

  (define (case-i-re pattern)
    (pregexp (string-append "(?i:" pattern ")")))

  (define (line-re pattern)
    (pregexp (string-append "^" pattern "$")))

  (define (re flags pattern)
    (cond [(case-insensitive? flags) (case-i-re pattern)]
          [(match-line? flags) (line-re pattern)]
          [else (regexp pattern)]))

  (define (display-line flags file line n)
    ;(printf "line: ~a\n" line)
    (cond [(show-line-numbers? flags) (format "~a:~a" n line)]
          [(show-filename? flags) file]
          [else line]))

  (let loop ([files files])
    (let* ([file (car files)]
           [path (build-path (current-directory) file)]
           [matches empty]
           [lines (file->lines path)])
      (for/list ([line (in-list lines)]
                 [n (in-naturals 1)]
                 #:when (regexp-match (re flags pattern) line))
        (display-line flags file line n)))
    (when (not (empty? (cdr files)))
      (loop (cdr files)))))

#| (cond [(regexp-match (re flags pattern) line) (display-line flags file line n)]) |#
#|       [else] |#
#|         (when (invert-match? flags)) |#
#|           (display-line flags file line n) |#
