(ns acronym
  (:require [clojure.string :as str]))

(defn split-words [s]
  (str/split s #"\b"))

(defn first-character [s]
  (subs s 0 1))

(defn capitalize [s]
  (let [len (count s) remaining-chars (subs s 1 len)]
    (str (str/upper-case (first-character s)) remaining-chars)))

(defn keep-alpha [s]
  (re-find #"^[A-Za-z]" s))

(defn split-mixed-case [s]
  (str/replace s #"([A-Z]{1}[a-z]+)" "$1 "))

(defn acronym [s]
  (if (empty? s)
    s
    (str/join (map first-character (map capitalize (filter keep-alpha (split-words (split-mixed-case s))))))))
