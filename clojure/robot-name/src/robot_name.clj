(ns robot-name)

(def memory (atom {}))
(def robots (atom #{}))

(defn random-name []
  (let [letters (repeatedly 2 #(char (+ (rand 26) 65)))
        numbers (repeatedly 3 #(rand-int 10))
        its-name (apply str (concat letters numbers))]
    (if (contains? @robots its-name) (recur) its-name)))

(defn update-memory [robot-key robot-name]
  (swap! robots conj robot-name)
  (swap! memory assoc robot-key robot-name))

(defn robot []
  (let [robot-key (keyword (gensym "robot-")) robot-name (random-name)]
    (update-memory robot-key robot-name)
    robot-key))

(defn robot-name [robot-key]
  (@memory robot-key))

(defn reset-name [robot-key]
  (when (contains? @robots (@memory robot-key)) (update-memory robot-key (random-name))))
