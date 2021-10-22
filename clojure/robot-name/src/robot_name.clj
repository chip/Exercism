(ns robot-name)

(defn random-name []
  (let [letters (repeatedly 2 #(char (+ (rand 26) 65)))
        numbers (repeatedly 3 #(rand-int 10))]
    (apply str (concat letters numbers))))

(def memory (atom {}))
(def robots (atom #{}))

(defn robot-name [id]
  (@memory id))

(defn ensure-new-name [id]
  (loop [n (random-name)]
    (if (@robots n)
      (recur id)
      (do
        (swap! robots disj (robot-name id))
        (swap! robots conj n)
        (swap! memory assoc id n)))))

(defn robot []
  (let [id (gensym "robot-")]
    (ensure-new-name id)
    id))

(defn reset-name [id]
  (ensure-new-name id))
