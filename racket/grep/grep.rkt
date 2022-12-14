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

  (define (rx pattern [start ""] [end ""])
    (regexp (string-append start pattern end)))

  (define (regex pattern flags)
    (let ([ci? (case-insensitive? flags)]
          [ml? (match-line? flags)])
      (cond 
        [(and ci? ml?) (rx pattern "^(?i:" ")$")]
        [ci? (rx pattern "(?i:" ")")]
        [ml? (rx pattern "^" "$")]
        [else (rx pattern)])))

  (define (show-line? line pattern flags)
    (let ([match? (regexp-match (regex pattern flags) line)])
      (if (invert-match? flags)
        (not match?)
        match?)))

  (define (format-line-single-file flags file line n)
    (cond
      [(show-line-numbers? flags) (format "~a:~a" n line)]
      [else (format "~a" line)]))

  (define (format-line-multiple-files flags file line n)
    (cond
      [(show-line-numbers? flags) (format "~a:~a:~a" file n line)]
      [else (format "~a:~a" file line)]))

  (define (show-line flags file line n)
    (cond
      [(show-filename? flags) (format "~a" file)]
      [(= 1 (length files)) (format-line-single-file flags file line n)]
      [else (format-line-multiple-files flags file line n)]))

  (define (process file pattern flags)
    (define file-lines
      (file->lines (build-path (current-directory) file)))
    (remove-duplicates
      (filter (lambda (s)
                (not (void? s)))
        (flatten
          (map (lambda (line n)
                 (when (show-line? line pattern flags)
                   (show-line flags file line n)))
               file-lines (range 1 (add1 (length file-lines))))))))

  (flatten (map (lambda (file) (process file pattern flags)) files)))
