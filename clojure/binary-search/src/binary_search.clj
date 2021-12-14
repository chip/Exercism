(ns binary-search)

(defn middle [coll]
  (int (Math/floor (/ (count coll) 2))))

(defn search-for [n coll]
  (let [cells (vec (map-indexed vector coll))]
    (loop [n n c cells]
      (let [m (middle c) [i x] (get c m)]
        (cond
          (and (not= n x) (= 1 (count c))) (throw (Exception. "not found"))
          (> n x) (recur n (vec (nthrest c m)))
          (< n x) (recur n (vec (take (inc m) c)))
          :else i)))))
