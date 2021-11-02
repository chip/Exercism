(ns nth-prime)

(defn remainders
  "answer vector of remainders when N is divided by 2..n/2"
  [n] (map (partial mod n) (range 2 (inc (/ n 2)))))

(defn prime?
  "answer true if n is prime"
  [n] (every? (complement zero?) (remainders n)))

(defn counter
  "increment primes counter if candidate is prime"
  [candidate primes]
  (if (prime? candidate) (inc primes) primes))

(defn nth-prime
  "find the prime number at position n"
  [n]
  (if (zero? n)
    (throw (IllegalArgumentException. "there is no zeroth prime"))
    (loop [candidate 2 previous candidate primes 0]
      (if (= n primes)
        previous 
        (recur (inc candidate) candidate (counter candidate primes))))))
