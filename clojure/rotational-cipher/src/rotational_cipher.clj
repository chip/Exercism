(ns rotational-cipher
  (:require [clojure.string :as str]))

(defn generate-letters [n] (into [] (map #(char (+ % n)) (range 26))))

; upper-case letters
(defn upper-case-letters [] (generate-letters 65))

; lower-case letters
(defn lower-case-letters [] (generate-letters 97))

; (prn "lower-case-letters:" (get (lower-case-letters) 4))

(defn operator [n]
  (if (pos? n) + -))

(defn lower-case? [c]
  (= (str c) (str/lower-case c)))

(defn upper-case? [c]
  (= (str c) (str/upper-case c)))
; create letter mapping (see upper-case-letters, lower-case-letters)
; find letter index
; find offset (rem n 26)
; find replacement letter index from offset
; return letter using offset index
(defn letter-index [c]
  (cond
    (lower-case? c) (first (keep-indexed #(when (= c %2) %1) (lower-case-letters)))
    (upper-case? c) (first (keep-indexed #(when (= c %2) %1) (upper-case-letters)))
    ))

(defn process [c n]
  (prn "process c n" c n)
  (let [i (letter-index c)]
    (cond 
      (nil? i) (do
                 (prn "skipping" c)
                 c
                 )
      :else (let [o (mod (+ n i) 26)]
              (prn "n i o " n i o)
              (if (lower-case? c)
                (char (+ o 97))
                (char (+ o 65)))
                ; (prn "remainder" remainder)
                ; (prn "nth" (nth (lower-case-letters) i))
                ; (let [r (char ((operator remainder) remainder i))]
                ; r
                ))))

(lower-case-letters)
; find remainder of n 26
; if remainder is negative subtract from letter index - otherwise, add
;

(defn map-char [c n]
  ; (prn "map-char c" c)
  ; (prn "char + int c 65 n" (char (+ (int c) n)))
  (cond 
    (or (lower-case? c) (upper-case? c)) (process c n)
    :else c
    ))

(defn rotate [s n]
  ; (prn "n" n)
  (apply str (map #(map-char %1 n) s)))

; (rotate "fob" 1)
; (rotational-cipher/rotate "Testing 1 2 3 testing" 4); "Xiwxmrk 1 2 3 xiwxmrk")))
