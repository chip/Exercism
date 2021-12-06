(ns strain)

(defn retain [pred coll]
  (loop [retained [] remaining coll]
    (if (empty? remaining)
      retained
      (if (pred (first remaining))
        (recur (conj retained (first remaining)) (rest remaining))
        (recur retained (rest remaining))))))

(defn discard [pred coll]
  (if (empty? coll)
    coll
    (if (pred (first coll))
      (discard pred (rest coll))
      (cons (first coll) (discard pred (rest coll))))))
