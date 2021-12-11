(ns run-length-encoding)

(defn char-count
  "return character count only when greater than 1"
  [matches]
  (when (> (count matches) 1)
    (count matches)))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [s]
  (->> s
    (partition-by identity)
    (map #(str (char-count %) (str (first %))))
    (reduce str "")))

(defn decode
  "accepts regex matcher vector to determine how to repeat letters"
  [[_ n letter]]
  (if-not (nil? n)
    (apply str (repeat (int (bigdec n)) letter))
    (str letter)))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [s]
  (let [matcher (re-seq #"([0-9]+)?([A-Za-z ]{1})" s)]
    (reduce str "" (map decode matcher))))
