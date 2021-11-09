(ns pangram
  (:require [clojure.set :as set])
  (:require [clojure.string :as str]))

(defn alphabet []
  (set (seq "abcdefghijklmnopqrstuvwxyz")))

(defn letters [s]
  (set (keys (frequencies (str/lower-case s)))))

(defn pangram? [s]
  (= 26 (count (set/intersection (alphabet) (letters s)))))
