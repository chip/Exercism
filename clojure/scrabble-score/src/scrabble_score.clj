(ns scrabble-score
  (:require [clojure.string :as str ]))

(defn score-letter [s]
  (let [c (str/lower-case s)]
    (cond
      (str/index-of "dg" c) 2
      (str/index-of "bcmp" c) 3
      (str/index-of "fhvwy" c) 4
      (str/index-of "k" c) 5
      (str/index-of "jx" c) 8
      (str/index-of "qz" c) 10 
      :else 1)))

(defn score-word [w]
  (reduce + (map score-letter w)))
