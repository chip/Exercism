(ns all-your-base)

(defn list-to-int [nums]
  (Integer/parseInt (apply str nums)))

(defn fmt [memo remainder]
  (concat memo (list remainder)))

(defn to-base [n base]
  (loop [x n memo '()]
    (let [quotient (quot x base) remainder (rem x base) data (fmt memo remainder)]
      (if (zero? quotient)
        (reverse data)
        (recur quotient (flatten (conj data)))))))

(defn num-to-list [x]
  (for [n (str x)]
    (- (byte n) 48)))

(defn decimal-to-binary? [b1 b2]
  (and (= 10 b1) (= 2 b2)))

(defn valid-base? [base nums]
  (not (some #(or (neg? %) (>= % base)) nums)))

(defn valid? [b1 nums b2]
  (and (pos? b1) (not= 1 b1) (pos? b2) (not= 1 b2) (valid-base? b1 nums)))

(defn power-of-base [[i n] b1]
  (int (* n (Math/pow b1 i))))

(defn powers [b1 nums]
  (num-to-list
    (reduce +
            (map #(power-of-base % b1)
              (reverse (map-indexed vector (reverse nums)))))))

(defn convert [b1 nums b2]
  (if (valid? b1 nums b2)
    (if (empty? nums)
      (list)
      (if (decimal-to-binary? b1 b2)
        (to-base (list-to-int nums) b2)
        (let [p1 (powers b1 nums)]
          (cond
            (= b2 16) (to-base (list-to-int p1) b2)
            (= b2 3) (to-base (list-to-int p1) b2)
            (= b2 73) (to-base (list-to-int p1) b2)
            :else p1)
          )))))
