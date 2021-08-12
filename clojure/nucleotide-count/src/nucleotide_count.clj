(ns nucleotide-count
  (:require
    [clojure.string :as str]))

(defn dna-alphabet [] (list \A \C \G \T))

(defn count-of-nucleotide-in-strand [nucleotide strand]
  (if (not (some #(= nucleotide %) (dna-alphabet)))
    (throw (Exception. (format "Nucleotide %s does not exist" nucleotide)))
    (if (str/blank? strand)
      0
      (count (filterv #(= (str nucleotide) (str %)) (re-seq #"." strand))))))

(defn nucleotide-counts [strand]
  (if (str/blank? strand)
    (into {} (map #(hash-map % 0) (dna-alphabet)))
    (into {} (map #(hash-map % (count-of-nucleotide-in-strand % strand)) (dna-alphabet)))))
