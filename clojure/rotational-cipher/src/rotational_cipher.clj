(ns rotational-cipher
  (:require [clojure.string :as str :only [index-of]]))

(def uppercase "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
(def lowercase "abcdefghijklmnopqrstuvwxyz")
(def ascii-offset-A 65)
(def ascii-offset-a 97)
(def alphabet-count 26)

(defn convert-char
  "Find index i of letters in lowercase/uppercase string.
  Add index i to n arg to get the remainder when divisor is alphabet-count.
  Remainder is used in cases where offset will be out-of-bounds of letters string.
  Return ascii character of letter based on letters."
  [c n letters offset]
  (let [i (str/index-of letters c)]
    (char (+ (mod (+ n i) alphabet-count) offset))))

(defn filter-alphabet
  "Process upper and lower case letters; skip others"
  [c n]
  (cond
    (re-find #"[A-Z]" (str c)) (convert-char c n uppercase ascii-offset-A) 
    (re-find #"[a-z]" (str c)) (convert-char c n lowercase ascii-offset-a) 
    :else c))

(defn rotate
  "Rotate each character of string s by n offset"
  [s n]
  (apply str (map #(filter-alphabet (str %1) n) s)))
