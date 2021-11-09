(ns pangram
  (:require [clojure.set :as set])
  (:require [clojure.string :as str]))

(defn alpha []
  (set '(\a \b \c \d \e \f \g \h \i \j \k \l \m \n \o \p \q \r \s \t \u \v \w \x \y \z)))

(defn letters [s]
  (set (keys (frequencies (str/lower-case s)))))

(defn pangram? [s]
  (= 26 (count (set/intersection (alpha) (letters s)))))
