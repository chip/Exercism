(ns raindrops)

(defn sound [n [d s]]
  (if (zero? (mod n d)) s ""))

(defn raindrops [n]
  (map #(sound n %) {3 "Pling" 5 "Plang" 7 "Plong"}))
  
(defn convert [n]
  (let [s (apply str (raindrops n))]
    (if (empty? s) (str n) s)))
