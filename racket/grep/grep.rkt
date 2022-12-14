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

  (define (multiple-files? flags)
    (> (length files) 0))
 
  (define (show-filename? flags)
    (or (member "-l" flags) (multiple-files? flags)))

  (define (regex pattern flags)
    (cond [(case-insensitive? flags) (regexp (string-append "(?i:" pattern ")"))]
          [(match-line? flags) (regexp (string-append "^" pattern "$"))]
          [else (regexp pattern)]))

  (define (show-line? line pattern flags)
    (if (invert-match? flags)
      (not (regexp-match (regex pattern flags) line))
      (regexp-match (regex pattern flags) line)))

  (define (show-line flags file line n)
    (cond [(multiple-files? flags) (format "~a" file)]
          [(show-filename? flags) (format "~a" file)]
          [(show-line-numbers? flags) (format "~a:~a" n line)]
          [else (format "else: ~a" line)]))

  (define (process file pattern flags)
    (define file-lines
      (file->lines (build-path (current-directory) file)))
    (for/list ([line file-lines]
               [n (range 1 (add1 (length file-lines)))]
               #:when (show-line? line pattern flags))
      (show-line flags file line n)))

  (flatten (map (lambda (file) (process file pattern flags)) files)))

;(grep '("-x") "Eden" '("paradise-lost.txt"))
