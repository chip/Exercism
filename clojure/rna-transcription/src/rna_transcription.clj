(ns rna-transcription)

(def rna-complement {\G \C, \C \G, \T \A, \A \U})

(defn translate [dna]
  (or (get rna-complement dna) (throw (AssertionError. "Invalid DNA strand"))))

(defn to-rna [dna]
  (apply str (map translate dna)))
