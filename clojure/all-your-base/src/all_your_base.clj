(ns all-your-base)

(defn to-base [n base]
  (loop [x n memo '()]
    (let [quotient (quot x base)]
      (if (zero? quotient)
        (conj memo (rem x base))
        (recur quotient (flatten (conj memo (rem x base))))))))

(defn powers-of [b1 nums]
  (reduce + (map #(* %1 %2) (iterate #(* % b1) 1) (reverse nums))))

(defn process-data [b1 nums b2]
  (to-base (powers-of b1 nums) b2))

(defn valid? [b1 nums b2]
  (and (seq nums) (> b2 1) (> b1 1) (every? #(< -1 % b1) nums)))

(defn convert [b1 nums b2]
  (when (valid? b1 nums b2)
    (process-data b1 nums b2)))
