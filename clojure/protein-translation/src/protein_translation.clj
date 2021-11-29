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

(defn translate-codon [s]
  (let [k (keyword s)]
    (if (stop k) "STOP" (codons k))))

(defn translate-rna [s]
  (into [] (take-while #(not (= "STOP" %))
                       (map #(translate-codon (first %)) (re-seq #"(.){3}" s)))))
