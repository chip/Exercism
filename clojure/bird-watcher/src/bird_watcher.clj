(ns bird-watcher)

(def last-week 
  (vec [0 2 5 3 7 8 4]))

(defn today [birds]
  (last birds))

(defn inc-bird [birds]
  (let [bird-count (count birds) last-index (dec bird-count) bird (last birds)]
    (assoc birds last-index (inc bird))))

(defn day-without-birds? [birds]
  (not (not-any? zero? birds)))

(defn n-days-count [birds n]
  (reduce + (subvec birds 0 n)))

(defn busy-days [birds]
  (count (filter #(>= % 5) birds)))

(defn odd-week? [birds]
  (every? true? (map #(or (= 1 %) (= 0 %)) birds)))
