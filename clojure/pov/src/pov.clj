(ns pov)

(def simple-pulled [:x [:parent [:sibling]]])
(subvec simple-pulled 1)

(defn of [input target]
  (prn "of input " input)
  (prn "of target " target)
  (vector input)
)

(defn path-from-to []
)
