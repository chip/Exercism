(ns run-length-encoding)

(defn text-matcher [t]
  (re-matcher #"([A-Za-z ])\1*" t))

(defn parse [plain-text]
  (prn "parse" plain-text)
  (let [m (re-matcher #"([A-Za-z ])\1*" plain-text)]
    (loop [acc ""]
      (prn "acc" acc)
      (let [match (re-find m)]
        (if match
          (do
            (prn "match" match)
            (prn "get match 0" (get match 0))
            (prn "first match" (first match))
            (let [c (count (get match 0)) letter (get match 1)]
              (if (> c 1)
                (recur (str acc c letter))
                (recur (str acc letter))
                )))
          acc
          )))))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [plain-text]
  (if (empty? plain-text) plain-text (parse plain-text)))

(defn convert-count [c]
  (cond 
    (or (nil? c) (= " " c)) 1
    :else (Integer/parseInt c)
    ))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  (prn "cipher-text:" cipher-text)

  (let [m (re-matcher #"([0-9]+)?([A-Za-z ]{1})" cipher-text)]
    (loop [acc ""]
      (prn "acc:" acc)
      (let [match (re-find m)]
        (if match
          (do
            (prn "match:" match)
            (prn "2nd match:" (second match))
            (let [sm (second match)]
              ; (prn "2nd match parsed:" (Integer/parseInt ((fnil + 0) sm))))
              (prn "last match:" (last match))
              ; (prn "fnil" ((fnil + 0) (get match 1)))
              ; (prn "fnil second" ((fnil + 0) (Integer/parseInt (second match))))
              (let [c (convert-count sm) letter (last match) s (apply str (repeat c letter))]
                (prn "c" c)
                (prn "s" s)
                (prn "letter" letter)
                (recur (str acc s))
                )
              ))
          acc
          )
        ))))

; (= "3z 2Z2 zZ" (run-length-encode "zzz ZZ  zZ"))
; (= "zzz ZZ  zZ" (run-length-decode "3z 2Z2 zZ"))
(run-length-decode "3z 2Z2 zZ")
