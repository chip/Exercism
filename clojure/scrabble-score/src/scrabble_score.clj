(ns scrabble-score
  (:require [clojure.string :as str]))

(defn score-letter [s]
  (let [c (str/lower-case s)]
    (cond
      (= c "a") 1
      (= c "b") 3
      (= c "c") 3
      (= c "d") 2
      (= c "e") 1
      (= c "f") 4
      (= c "g") 2
      (= c "h") 4
      (= c "i") 1
      (= c "j") 8
      (= c "k") 5
      (= c "l") 1
      (= c "m") 3
      (= c "n") 1
      (= c "o") 1
      (= c "p") 3
      (= c "q") 10
      (= c "r") 1
      (= c "s") 1
      (= c "t") 1
      (= c "u") 1
      (= c "v") 4
      (= c "w") 4
      (= c "x") 8
      (= c "y") 4
      (= c "z") 10
      :else 0)))

(defn score-word [w]
  (reduce + (map score-letter w)))
