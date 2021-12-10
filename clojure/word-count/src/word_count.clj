(ns word-count
  (:require [clojure.string :as str]))

(defn word-count
  "Given a phrase, count the occurrences of each word in that phrase"
  [s]
  (->> (str/lower-case s)
       (re-seq #"\w+")
       (frequencies)))
