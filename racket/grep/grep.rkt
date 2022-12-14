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
    (member "-l" flags))

  (define (regex pattern flags)
    (cond 
          [(and (case-insensitive? flags) (match-line? flags)) (regexp (string-append "^(?i:" pattern ")$"))]
          [(case-insensitive? flags) (regexp (string-append "(?i:" pattern ")"))]
          [(match-line? flags) (regexp (string-append "^" pattern "$"))]
          [else (regexp pattern)]))

  (define (show-line? line pattern flags)
    (if (invert-match? flags)
      (not (regexp-match (regex pattern flags) line))
      (regexp-match (regex pattern flags) line)))

  (define (format-line-single-file flags file line n)
    ;(printf "s flags: ~a\n" flags)
    (cond
          [(show-filename? flags) (format "~a" file)]
          [(show-line-numbers? flags) (format "~a:~a" n line)]
          ;[(and (multiple-files? flags) (show-line-numbers? flags)) (format "~a:~a:~a" file n line)]
          ;[(multiple-files? flags) (format "~a" line)]
          [else (format "~a" line)]))

  (define (format-line-multiple-files flags file line n)
    ;(printf "mult flags: ~a\n" flags)
    (cond
          [(show-filename? flags) (format "~a" file)]
          [(show-line-numbers? flags) (format "~a:~a:~a" file n line)]
          ;[(and (multiple-files? flags) (show-line-numbers? flags)) (format "~a:~a:~a" file n line)]
          ;[(multiple-files? flags) (format "~a" line)]
          ;[else (format "~a" line)]
          [else (format "~a:~a" file line)]))

  (define (show-line flags file line n)
    (cond
          [(= 1 (length files)) (format-line-single-file flags file line n)]
          [else (format-line-multiple-files flags file line n)]))

  (define (process file pattern flags)
    (define file-lines
      (file->lines (build-path (current-directory) file)))
    (define matches empty)
    (filter (lambda (s)
              (not (void? s)))
      (flatten
        (map (lambda (line n)
               (let ([ln (show-line flags file line n)])
                 #| (printf (list->string matches)) |#
                 #| (printf ln) |#
                 ;(when (and (show-line? line pattern flags) (not (member ln matches))))
                 (when (show-line? line pattern flags)
                   ln)))
             file-lines (range 1 (add1 (length file-lines)))))))

  (flatten
    (map (lambda (file)
           (process file pattern flags))
         files)))
