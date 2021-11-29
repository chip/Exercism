(ns protein-translation)

(def stop #{:UAA :UAG :UGA})
(def codons {:AUG "Methionine"
             :UUU "Phenylalanine"
             :UUC "Phenylalanine"
             :UUA "Leucine"
             :UUG "Leucine"
             :UCU "Serine"
             :UCC "Serine"
             :UCA "Serine"
             :UCG "Serine"
             :UAU "Tyrosine"
             :UAC "Tyrosine"
             :UGU "Cysteine"
             :UGC "Cysteine"
             :UGG "Tryptophan"})

(defn codon-seq [s]
  (re-seq #"(.){3}" s))

(defn translate-codon [s]
  (let [k (keyword s)]
    (if (stop k)
      "STOP"
      (codons k))))

(defn valid [s]
  (not= "STOP" s))

(defn translate-rna [s]
  (into [] (take-while valid (map #(translate-codon (first %1)) (codon-seq s)))))
