(ns anagram
  (:require [clojure.string :as str]))

(defn match [s d]
  (= (frequencies s) (frequencies d)))

(defn anagram [s d]
  (or (and (not= s d) (match s d))
      (match (str/lower-case s) (str/lower-case d))))

(defn anagrams-for [word prospect-list]
  (filter #(anagram word %) prospect-list))
