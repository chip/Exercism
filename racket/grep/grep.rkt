#lang racket

(provide grep)

(define (grep flags pattern files)
  (define (case-insensitive? flags)
    (member "-i" flags))

  (define (show-line-numbers? flags)
    (member "-n" flags))

  (define (match-line? flags)
    (member "-x" flags))

  (define (invert-match? flags)
    (member "-v" flags))

  (define (show-filename? flags)
    (member "-l" flags))

  (define (case-i-re pattern)
    (regexp (string-append "(?i:" pattern ")")))

  (define (line-re pattern)
    (regexp (string-append "^" pattern "$")))

  (define (re pattern)
    (regexp pattern))

  (define (regex pattern flags)
    (cond [(case-insensitive? flags) (case-i-re pattern)]
          [(match-line? flags) (line-re pattern)]
          [else (re pattern)]))

  (define (display-line flags file line n)
    (cond [(show-line-numbers? flags) (format "~a:~a" n line)]
          [(show-filename? flags) (format "file: ~a" file)]
          [else (format "~a" line)]))

  (define (line-matches? line pattern flags)
    (let* ([rx (regex pattern flags)]
           [r (regexp-match rx line)])
      #| (printf "rx: ~a\t~a\n" rx line) |#
      (regexp-match (regex pattern flags) line)))

  (define (lines file pattern flags)
    (define file-lines
      (file->lines (build-path (current-directory) file)))
    (for/list ([line file-lines]
               [n (range 1 (length file-lines))]
               #:when (line-matches? line pattern flags))
      (let ([dl (display-line flags file line n)])
        dl)))

  (define (process file pattern flags)
    (let ([b (lines file pattern flags)])
      b))

  (for/list ([file files])
    (let ([p (process file pattern flags)])
      (printf "file: ~a\t pattern: ~a\tflags: ~a\tp: ~a\n" file pattern flags p)
      (if (empty? p)
        p
        (first p)))))
