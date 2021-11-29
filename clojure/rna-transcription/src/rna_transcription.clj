(ns rna-transcription
  (:require [clojure.string :as str]))

(def dna-to-rna {:G "C", :C "G", :T "A", :A "U"})

(defn translate [dna]
  (if-let [t (get dna-to-rna (keyword dna))]
    t
    (throw (AssertionError. "Invalid DNA strand"))))

(defn to-rna [dna]
  (str/join (map #(translate (first %)) (re-seq #"(.)" dna))))
