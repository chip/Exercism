#lang racket

(provide grep)

(define (grep flags pattern files)

  (define (show-line-numbers? flags)
    (member "-n" flags))
  
  (define (case-insensitive? flags)
    (member "-i" flags))

  (define (case-i-re pattern)
    (printf (pregexp (string-append pattern "i")))
    (pregexp (string-append pattern "i")))

  (define (re flags pattern)
    (cond [(case-insensitive? flags) (case-i-re pattern)]
          [else (regexp pattern)]))

  (define (display-line flags line n)
    ;(printf "line: ~a\n" line)
    (cond [(show-line-numbers? flags) (format "~a:~a" n line)]
          [else line]))

  (let loop ([files files])
    (let* ([file (car files)]
           [path (build-path (current-directory) file)]
           [matches empty]
           [lines (file->lines path)])
      (for/list ([line (in-list lines)]
                 [n (in-naturals 1)]
                 #:when (regexp-match (re flags pattern) line))
        (display-line flags line n)))))

;     (test-equal? "Multiple files, no matches, various flags"
;                  (grep '("-n" "-l" "-x" "-i")
;                        "Frodo"
;                        '("iliad.txt" "midsummer-night.txt" "paradise-lost.txt"))
;                  '())))

