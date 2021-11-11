(ns pig-latin
  (:require [clojure.string :as str]))

(def vowels #{\a \e \i \o \u})

(defn all-consonants? [s n]
  (not-any? #(contains? vowels %) (take n s)))

(defn starts-with-consonant-cluster? [s]
  (all-consonants? s 2))

(defn starts-with-vowel-sound? [s]
  (or
    (= "yt" (subs s 0 2))
    (= "xr" (subs s 0 2))
    (not (all-consonants? s 1))))

(defn matcher-var [s]
  (if (str/starts-with? s "qu")
    (str "{2}")
    (str "*" s)))

(defn matcher-str [s]
  (prn "matcher-str" (str "^(." (matcher-var s) ")(.+)$"))
  (str "^(." (matcher-var s) "(.+)$"))

(defn parse [s]
  (prn "parse" s)
  (let [match (re-find (re-pattern (matcher-str s)) s)]
    (prn "match" match)
    (str (last match) (second match) "ay")))

(defn join-str [s n]
  (str (subs s n (count s)) (subs s 0 n) "ay"))

(defn words [s]
  (str/split s #"\s"))

(defn phrase? [s]
  (> (count (words s)) 1))

(defn process-word [s]
  ; (prn "process-word" s)
  (cond
    (starts-with-vowel-sound? s) (str s "ay")
    (str/starts-with? s "thr") (join-str s 3)
    (str/starts-with? s "th") (join-str s 2)
    (str/starts-with? s "ch") (join-str s 2)
    (str/starts-with? s "qu") (join-str s 2)
    (starts-with-consonant-cluster? s) (join-str s 3)
    (all-consonants? s 1) (join-str s 1)
    :else (parse s)))

(defn process-phrase [s]
  ; (prn "process-phrase" s)
  (str/join " " (map process-word (words s))))

(defn translate [s]
  (if (phrase? s) (process-phrase s) (process-word s)))
