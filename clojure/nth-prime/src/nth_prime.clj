(ns nth-prime)

(defn prime? [n]
  (let [limit (int (Math/sqrt n))
        divisors (range 2 (inc limit))]
    (not-any? #(zero? (mod n %)) divisors)))

(defn nth-prime
  "find the prime number at position n"
  [n]
  (if (zero? n)
    (throw (IllegalArgumentException. "there is no zeroth prime"))
    (nth (filter prime? (iterate inc 2)) (dec n))))
