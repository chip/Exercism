(ns collatz-conjecture)

(defn collatz [num]
  (if (not (pos? num))
    (throw (Exception. "Collatz calculation requires positive numbers"))
    (loop [count 0 current num]
      ; (println count "->" current)
      (if (= current 1)
        count
        (if (even? current)
          (recur (inc count) (/ current 2))
          (recur (inc count) (+ 1 (* current 3)))
        )
      )
    )
  )
)
