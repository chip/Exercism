(ns all-your-base)

(defn to-base [n b]
  (loop [q (quot n b), digits (list (rem n b))]
    (if (zero? q)
      digits
      (recur (quot q b) (conj digits (rem q b))))))

(defn to-decimal [b1 nums]
  (->> (reverse nums)
       (map * (iterate #(* % b1) 1))
       (reduce +)))

(defn valid? [b1 nums b2]
  (->> nums
    (every? #(< -1 % b1))
    (and (seq nums) (> b2 1) (> b1 1))))

(defn convert [b1 nums b2]
  (when (valid? b1 nums b2)
    (->
      (to-decimal b1 nums)
      (to-base b2))))
