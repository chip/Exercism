(ns run-length-encoding)

(defn encode-matcher [t]
  (re-matcher #"([A-Za-z ])\1*" t))

(defn letter-count [m]
  (let [c (count m)]
    (when (> c 1)
      c)))

(defn parse [plain-text]
  (let [matcher (encode-matcher plain-text)]
    (loop [acc ""]
      (let [match (re-find matcher)]
        (if match
          (let [[full-match letter] match, c (letter-count full-match)]
            (recur (str acc c letter)))
          acc)))))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [plain-text]
  (if (empty? plain-text) plain-text (parse plain-text)))

(defn convert-count [c]
  (cond 
    (or (nil? c) (= " " c)) 1
    :else (Integer/parseInt c)))

(defn decode-matcher [t]
  (re-matcher #"([0-9]+)?([A-Za-z ]{1})" t))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  (let [m (decode-matcher cipher-text)]
    (loop [acc ""]
      (let [match (re-find m)]
        (if match
          (let [sm (second match) c (convert-count sm) letter (last match)]
            (recur (str acc (apply str (repeat c letter)))))
          acc)))))
