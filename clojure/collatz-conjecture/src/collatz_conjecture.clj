(ns collatz-conjecture)

(defn divide-by-2 [x] (/ x 2))

(defn three-x-plus-1 [x] (+ 1 (* x 3)))

(defn collatz [num]
  (if (not (pos? num))
    (throw (Exception. "Collatz calculation requires positive numbers"))
    (loop [count 0 current num]
      (if (= current 1)
        count
        (recur (inc count) (if (even? current) (divide-by-2 current) (three-x-plus-1 current)))
      )
    )
  )
)
