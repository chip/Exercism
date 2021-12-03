(ns rotational-cipher)

(def ascii-offset-A 65)
(def ascii-offset-a 97)
(def alphabet-count 26)

(defn generate-letters [n] (into [] (map #(char (+ % n)) (range alphabet-count))))

(defn letters [c]
  (if (re-find #"[A-Z]" (str c))
    (generate-letters ascii-offset-A) ; upper-case letters 
    (generate-letters ascii-offset-a))) ; lower-case letterse

(defn letter-index [c]
  (first (keep-indexed #(when (= c %2) %1) (letters c))))

(defn ascii-offset [c]
  (if (re-find #"[A-Z]" (str c))
    ascii-offset-A
    ascii-offset-a))

(defn process [c n]
  (let [i (letter-index c) o (mod (+ n i) 26)]
    (char (+ o (ascii-offset c)))))

(defn map-char [c n]
  (cond
    (re-find #"[A-Za-z]" (str c)) (process c n)
    :else c))

(defn rotate [s n]
  (apply str (map #(map-char %1 n) s)))
