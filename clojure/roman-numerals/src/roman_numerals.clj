(ns roman-numerals)

(def roman-complement { 1000 "M"
                         900 "CM"
                         500 "D"
                         400 "CD"
                         100 "C"
                          90 "XC"
                          50 "L"
                          40 "XL"
                          10 "X"
                           9 "IX"
                           5 "V"
                           4 "IV"
                           1 "I" })

(defn divisor [n]
  (cond
    (>= n 1000) 1000
    (>= n 900) 900
    (>= n 500) 500
    (>= n 400) 400
    (>= n 100) 100
    (>= n 90) 90
    (>= n 50) 50
    (>= n 40) 40
    (>= n 10) 10
    (>= n 9) 9
    (>= n 5) 5
    (>= n 4) 4
    (>= n 1) 1
   ))

; (def roman-complement {1 \I, 5 \V, 10 \X, 50 \L, 100 \C, 500 \D, 1000 \M})
;; Convert a number to a roman numeral
;; Compares the number to the previous number in the list and subtracts
;; the previous number if the current number is greater than the previous

(defn divisors [a]
  (loop [divisors [] n a]
    (prn "divisors" divisors)
    (prn "loop n" n)
    (if (zero? n)
      divisors
      (let [d (divisor n) remainder (- n d)]
        (prn "d" d)
        (prn "remainder" remainder)
        (recur (conj divisors d) remainder)))))

(defn numerals [n]
  (prn "numerals" n)
  (let [d (divisors n)]
    (prn "numerals d" d)
    (apply str (map roman-complement d))))
