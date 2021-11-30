(ns roman-numerals)

(defn divisor [n]
  (cond
    (>= n 1000) [1000 "M"]
    (>= n 900) [900 "CM"]
    (>= n 500) [500 "D"]
    (>= n 400) [400 "CD"]
    (>= n 100) [100 "C"]
    (>= n 90) [90 "XC"]
    (>= n 50) [50 "L"]
    (>= n 40) [40 "XL"]
    (>= n 10) [10 "X"]
    (>= n 9) [9 "IX"]
    (>= n 5) [5 "V"]
    (>= n 4) [4 "IV"]
    (>= n 1) [1 "I"]))

(defn divisors [a]
  (loop [roman-numerals [] n a]
    (if (zero? n)
      roman-numerals
      (let [d (divisor n) remainder (- n (first d))]
        (recur (conj roman-numerals (last d)) remainder)))))

(defn numerals [n]
  (apply str (divisors n)))
