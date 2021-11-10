(ns pig-latin
  (:require [clojure.string :as str]))

(def patterns
  '("thr" "sch" "squ" "th" "ch" "qu" "q" "k" "y" "x" "p" "a" "e" "i" "o" "u"))

(defn starts-with-vowel?
  [s]
  ; (prn "starts-with-vowel?" s)
  (contains? #{"a" "e" "i" "o" "u"} (subs s 0 1)))

(defn starts-with-this
  [c s]
  (= c (subs s 0 (count c))))

(defn common?
  [s]
  (prn "common?" s)
  (first (filter #(starts-with-this % s) patterns)))

(defn matcher
  [s]
  (re-pattern (str "^(" s ")(.+)$")))

(defn pigify
  [s c]
  ; (prn "pigify" s c)
  (let [matches (re-find (matcher c) s)]
    (prn "matches " matches)
    (str (last matches) (second matches) "ay")))

(defn starts-with-vowel-then-qu?
  [s]
  ; (prn "starts-with-vowel-then-qu?" s)
  (and (starts-with-vowel? s) (= "qu" (subs s 1 3))))

(defn starts-with-q-only?
  [s]
  (and (not (starts-with-this "qu" s)) (starts-with-this "q" s)))

(defn words
  [s]
  (str/split s #"\s"))

(defn phrase?
  [s]
  (> (count (words s)) 1))

(defn process-word
  [s]
  (prn "process-word" s)
  (let [start (common? s)]
    (prn "start" start)
    (cond
      (nil? start) (str (subs s 1 (count s)) (subs s 0 1) "ay")
      (starts-with-q-only? s) (pigify s start)
      (starts-with-vowel-then-qu? s) (str s "ay")
      (starts-with-this "yt" s) (str s "ay")
      (starts-with-this "xr" s) (str s "ay")
      (starts-with-vowel? s) (str s "ay")
      (common? s) (pigify s start)
      :else (do
              (prn "else")
              (str s "ay")
              ))))

(defn process-phrase
  [s]
  (str/join " " (map process-word (words s))))

(defn translate
  [s]
  (prn "translate " s)
  (if (phrase? s) (process-phrase s) (process-word s)))
