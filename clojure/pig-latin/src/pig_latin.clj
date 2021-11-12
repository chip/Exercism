(ns pig-latin
  (:require [clojure.string :as str]))

(def vowels #{\a \e \i \o \u})

(defn starting-consonants [s]
  (take-while #(not (contains? vowels %)) s))

(defn special-sounds-beginning [s]
  (first (filter #(str/starts-with? s %) '("squ" "qu" "thr" "th" "sch" "ch"))))

(defn length [s]
  (let [beginning (special-sounds-beginning s)]
    (if beginning (count beginning) (count (starting-consonants s)))))

(defn vowel-sound? [s]
  (or (not (starting-consonants s)) (some #(str/starts-with? s %) '("xr" "yt"))))

(defn process-word [s]
  (cond
    (vowel-sound? s) (str s "ay")
    :else (let [n (length s)] (str (subs s n (count s)) (subs s 0 n) "ay"))))

(defn words [s]
  (str/split s #"\s"))

(defn phrase? [s]
  (> (count (words s)) 1))

(defn translate [s]
  (if (phrase? s)
    (str/join " " (map process-word (words s)))
    (process-word s)))
