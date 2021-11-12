(ns all-your-base)

(defn to-base [n b]
  (loop [digits (list (rem n b)), q (quot n b)]
    (if (zero? q)
      digits
      (recur (conj digits (rem q b)) (quot q b)))))

(defn to-decimal [b1 nums]
  (->> (reverse nums)
       (map * (iterate #(* % b1) 1))
       (reduce +)))

(defn valid? [b1 nums b2]
  (and (seq nums) (> b2 1) (> b1 1) (every? #(< -1 % b1) nums)))

(defn convert [b1 nums b2]
  (when (valid? b1 nums b2)
    (->
      (to-decimal b1 nums)
      (to-base b2))))
