(ns robot-name
  (:require [clojure.string :as str]))

(def memory (atom {}))
(def robots (atom #{}))

(defn random-letters []
  (str/join "" (take 2 (repeatedly #(char (+ (rand 26) 65))))))

(defn random-numbers []
  (str/join "" (take 3 (repeatedly #(rand-int 10)))))

(defn random-name []
  (let [its-name (str (random-letters) (random-numbers))]
    (if (contains? @robots its-name) (recur) its-name)))

(defn random-key []
  (keyword (gensym "robot-")))

(defn get-name [robot-key]
  (if-let [robot-name (get @memory robot-key)]
    robot-name
    nil))
  
(defn update-memory [robot-key robot-name]
  (swap! robots conj robot-name)
  (swap! memory conj (hash-map robot-key robot-name)))

(defn robot-exists? [robot-key]
  (contains? @robots (get-name robot-key)))

(defn robot []
  (let [robot-key (random-key) robot-name (random-name)]
    (update-memory robot-key robot-name)
    robot-key))

(defn robot-name [robot-key]
  (get-name robot-key))

(defn reset-name [robot-key]
  (let [robot-name (random-name)]
    (if (robot-exists? robot-key)
      (do
        (update-memory robot-key robot-name)
        robot-key
      )
      nil)))
