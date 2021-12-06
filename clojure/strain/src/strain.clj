(ns strain)

(defn retain [pred coll]
  (reduce (fn [retained item]
            (if (pred item) (conj retained item) retained))
            []
            coll))

(defn discard [pred coll]
  (retain (complement pred) coll))
