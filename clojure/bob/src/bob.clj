(ns bob
  (:require [clojure.string :as str]))

(defn nothing-said? [s] (str/blank? (str/trim s)))
(defn ends-with-question? [s] (re-find #"\?$" (str/trim s)))
(defn has-lower-case? [s] (re-find #"[a-z]+" s))
(defn has-upper-case? [s] (re-find #"[A-Z]+" s))
(defn shouting? [s] (and (has-upper-case? s) (not (has-lower-case? s))))
(defn contains-letters? [s] (re-find #"[a-zA-Z]+" s))
(defn shouting-questions? [s] (and (ends-with-question? s) (shouting? s) (contains-letters? s)))

(defn response-for [s]
  (cond
    (nothing-said? s) "Fine. Be that way!"
    (shouting-questions? s) "Calm down, I know what I'm doing!"
    (shouting? s) "Whoa, chill out!"
    (ends-with-question? s) "Sure."
    :else "Whatever."))
