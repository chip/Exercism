(ns bob
  (:require [clojure.string :as str]))

(defn nothing-said? [s]
  (str/blank? s))

(defn ends-with-question? [s]
  (re-find #"\?$" s))

(defn has-lower-case? [s]
  (re-find #"[a-z]+" s))

(defn has-upper-case? [s]
  (re-find #"[A-Z]+" s))

(defn shouting? [s]
  (and (has-upper-case? s) (not (has-lower-case? s))))

(defn shouting-questions? [s]
  (and (ends-with-question? s) (shouting? s)))

(defn response-for [str]
  (let [s (str/trim str)]
    (cond
      (nothing-said? s) "Fine. Be that way!"
      (shouting-questions? s) "Calm down, I know what I'm doing!"
      (shouting? s) "Whoa, chill out!"
      (ends-with-question? s) "Sure."
      :else "Whatever.")))
