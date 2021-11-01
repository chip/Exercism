(ns all-your-base)

(defn append-memo [memo x base]
  (concat memo (list (rem x base))))

(defn to-base [n base]
  (loop [x (Integer/parseInt (apply str n)) memo '()]
    (let [quotient (quot x base)]
      (if (zero? quotient)
        (reverse (append-memo memo x base))
        (recur quotient (flatten (conj (append-memo memo x base))))))))

(defn number-list [x]
  (for [n (str x)]
    (- (byte n) 48)))

(defn pow [[i n] b1]
  (int (* n (Math/pow b1 i))))

(defn powers-of [b1 nums]
  (number-list (reduce + (map #(pow % b1) (reverse (map-indexed vector (reverse nums)))))))

(defn process-data [b1 nums b2]
  (let [data (powers-of b1 nums)]
    (cond
      (= b2 10) data
      (= b2 2) (to-base nums b2)
      :else (to-base data b2))))

(defn valid-base? [base nums]
  (not (some #(or (neg? %) (>= % base)) nums)))

(defn valid? [b1 nums b2]
  (and (seq nums) (pos? b2) (not= 1 b2) (valid-base? b1 nums)))

(defn convert [b1 nums b2]
  (if (valid? b1 nums b2)
    (process-data b1 nums b2)))
