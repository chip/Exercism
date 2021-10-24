(ns accumulate)

(defn accumulate
  [f & args]
  (let [v (first args)]
    (loop [coll v accum []]
      (let [r (rest coll) arg (first coll)]
        (if (nil? arg)
          accum
          (recur r (conj accum (f arg))))))))
