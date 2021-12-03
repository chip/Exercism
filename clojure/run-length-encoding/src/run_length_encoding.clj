(ns run-length-encoding)

(defn matcher
  "return appropriate regex match per given action"
  [text action]
  (if (= action :encode)
    (re-matcher #"([A-Za-z ])\1*" text)
    (re-matcher #"([0-9]+)?([A-Za-z ]{1})" text)))

(defn letter-count
  "return letter count if more than 1 is found"
  [m]
  (let [c (count m)]
    (when (> c 1)
      c)))

(defn encode
  "encode a regex match"
  [match]
  (let [[full-match letter] match]
    (str (letter-count full-match) letter)))

(defn match-count-to-int
  "convert regex match count to an integer: nil or single space to 1; \"3\" to 3"
  [s]
  (cond 
    (or (nil? s) (= " " s)) 1
    :else (Integer/parseInt s)))

(defn decode
  "decode a regex match"
  [match]
  (let [[_ c letter] match, n (match-count-to-int c)]
    (apply str (repeat n letter))))

(defn build-str
  "build string based on regex match; invoke fn based upon action arg"
  [action match]
  (if (= action :encode)
    (encode match)
    (decode match)))

(defn parse
  "parse text according to action"
  [text action]
  (let [m (matcher text action)]
    (loop [acc ""]
      (let [match (re-find m)]
        (if match
          (recur (str acc (build-str action match)))
          acc)))))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [s]
  (if (empty? s)
    s
    (parse s :encode)))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [s]
  (parse s :decode))
