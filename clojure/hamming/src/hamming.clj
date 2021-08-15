(ns hamming)

(defn hamming-occurs? [strand1 strand2 i]
  (let [c1 (.charAt strand1 i)
        c2 (.charAt strand2 i)
        occurs (not (= c1 c2))
        ]
    occurs))

(defn indexes [n] (range n))

(defn distance [strand1 strand2]
  (if (= strand1 strand2)
    0
    (if (= (count strand1) (count strand2))
      (count (filter identity (map #(hamming-occurs? strand1 strand2 %) (indexes (count strand1))))))))
