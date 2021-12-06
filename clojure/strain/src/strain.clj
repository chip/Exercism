(ns strain)

(defn retain [pred coll]
  (loop [retained [] remaining coll]
    (let [item (first remaining) remaining-items (rest remaining)]
      (if (empty? remaining)
        retained
        (if (pred item)
          (recur (conj retained item) remaining-items)
          (recur retained remaining-items))))))

(defn discard [pred coll]
  (if (empty? coll)
    coll
    (let [item (first coll) remaining-items (rest coll)]
      (if (pred item)
        (discard pred remaining-items)
        (cons item (discard pred remaining-items))))))
