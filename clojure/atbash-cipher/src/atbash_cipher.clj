(ns atbash-cipher
  (:require [clojure.string :as str]))

(def alphabet ["a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"])
(def letter-map (zipmap alphabet (reverse alphabet)))

(defn characters
  "Use character arg to return letter-map value if it exists - otherwise, return character arg"
  [s]
  (or (get letter-map s) (identity s)))

(defn encode
  "Encode characters using atbash cipher in 5 character groups"
  [s]
  (->> (str/lower-case s)
       (re-seq #"[a-z0-9]")
       (map characters)
       (partition-all 5)
       (map str/join)
       (str/join " ")))
