(ns anagram
  (:require [clojure.string :as str]))

(defn match [s d]
  (= (frequencies s) (frequencies d)))

(defn anagram [word candidate]
  (let [w (str/lower-case word) c (str/lower-case candidate)]
    (and (not= w c) (match w c))))

(defn anagrams-for [word prospect-list]
  (filter #(anagram word %) prospect-list))
