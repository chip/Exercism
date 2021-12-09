(ns sum-of-multiples)

(defn multiples-of-n-to-upper-limit [n limit]
  (take-while #(> limit %) (iterate (partial + n) n)))

(defn sum-of-multiples [list1 limit]
  (->> list1
       (mapcat #(multiples-of-n-to-upper-limit % limit))
       (distinct)
       (reduce +)))
