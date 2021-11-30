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
    (>= n 1) 1))

(defn divisors [a]
  (loop [divisors [] n a]
    (if (zero? n)
      divisors
      (let [d (divisor n) remainder (- n d)]
        (recur (conj divisors d) remainder)))))

(defn numerals [n]
  (apply str (map roman-complement (divisors n))))
