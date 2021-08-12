(ns collatz-conjecture)

; (defn _collatz [num]
;   (if (not (pos? num))
;     (throw (Exception. "Collatz calculation requires positive numbers"))
;     (if (= num 1)
;       0
;       (if (even? num)
;         (collatz(/ num 2))
;         (collatz(+ 1 (* num 3)))
;       )
;     )
;   )
; )

(defn collatz [num]
  (if (not (pos? num))
    (throw (Exception. "Collatz calculation requires positive numbers"))
    (if (= num 1)
      0
      (if (even? num)
        (collatz(/ num 2))
        (collatz(+ 1 (* num 3)))
      )
    )
  )
)

(collatz 12)
