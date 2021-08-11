(ns reverse-string
  (:require [clojure.string :as str]))

(defn reverse-string [s]
  (if (string? s)
    (str/join "" (reduce conj () (re-seq #"." s)))
    (println "No string provided")))
