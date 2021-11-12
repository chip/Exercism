(ns pig-latin
  (:require [clojure.string :as str]))

(def vowels #{\a \e \i \o \u})

(def special-sounds '("squ" "qu" "thr" "th" "sch" "ch"))

(defn special-consonant-sound? [s]
  (some #(str/starts-with? s %) special-sounds))

(defn starts-with-consonant? [s]
  (not-any? #(contains? vowels %) (take 1 s)))

(defn special-start [s]
  (first (filter #(str/starts-with? s %) special-sounds)))

(defn matcher-var [s]
  (if (special-consonant-sound? s)
    (str "{" (count (special-start s)) "}")
    (str "*" s)))

(defn matcher-str [s]
  (str "^(." (matcher-var s) ")(.+)$"))

(defn parse [s]
  (let [match (re-find (re-pattern (matcher-str s)) s)]
    (str (last match) (second match) "ay")))

(defn starting-consonants [s]
  (take-while #(not (contains? vowels %)) s))

(defn length [s]
  (let [special (special-start s)]
    (if special
      (count special)
      (count (starting-consonants s)))))

(defn join-str [s]
  (let [n (length s)]
    (str (subs s n (count s)) (subs s 0 n) "ay")))

(defn vowel-sound? [s]
  (or (not (starts-with-consonant? s)) (str/starts-with? s "yt") (str/starts-with? s "xr")))

(defn process-word [s]
  (cond
    (vowel-sound? s) (str s "ay")
    (or (special-consonant-sound? s) (starts-with-consonant? s)) (join-str s)
    :else (parse s)))

(defn words [s]
  (str/split s #"\s"))

(defn phrase? [s]
  (> (count (words s)) 1))

(defn translate [s]
  (if (phrase? s)
    (str/join " " (map process-word (words s)))
    (process-word s)))
