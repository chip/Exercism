(ns acronym
  (:require [clojure.string :as str]))

(defn words [s]
  (str/split s #"\b"))

(defn capitalize [s]
  (let [len (count s) first-char (subs s 0 1) remaining-chars (subs s 1 len)]
    (str (str/upper-case first-char) remaining-chars)))

(defn acronym [s]
  (if (empty? s)
    s
    (str/join
      (map #(subs % 0 1)
           (map capitalize
                (filter #(re-find #"^[A-Za-z]" %)
                        (words
                          (str/replace s #"([A-Z]{1}[a-z]+)" "$1 "))))))))
