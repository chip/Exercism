(ns robot-name)

(defn random-name []
  (let [letters (repeatedly 2 #(char (+ (rand 26) 65)))
        numbers (repeatedly 3 #(rand-int 10))]
    (apply str (concat letters numbers))))

(def memory (atom {}))
(def robots (atom #{}))

(defn update-memory [id its-name]
  (swap! robots conj its-name)
  (swap! memory assoc id its-name))

(defn ensure-new-name [id]
  (loop [its-name (random-name)]
    (if-not (@robots its-name)
      (update-memory id its-name)
      (recur id))))

(defn robot []
  (let [id (gensym "robot-")]
    (ensure-new-name id)
    id))

(defn robot-name [id]
  (@memory id))

(defn reset-name [id]
  (when (@robots (robot-name id))
    (ensure-new-name id)))
