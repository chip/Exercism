(ns phone-number
  (:require [clojure.string :as str]))

(defn strip-dots [num-string]
  (str/replace num-string #"\." ""))

(defn strip-parens [num-string]
  (str/replace num-string #"[\(\)]+" ""))

(defn strip-spaces [num-string]
  (str/replace num-string #"\s+" ""))

(defn strip-dashes [num-string]
  (str/replace num-string #"\-+" ""))

(defn strip-country-code [num-string]
  (if (= 11 (count num-string))
    (str/replace num-string #"^1" "")
    num-string))

(defn sanitize [num-string]
  (strip-country-code
    (strip-dots
      (strip-parens
        (strip-spaces
          (strip-dashes num-string))))))

(defn area-code [num-string]
  (subs (sanitize num-string) 0 3))

(defn exchange-code [num-string]
  (subs (sanitize num-string) 3 6))

(defn subscriber-number [num-string]
  (subs (sanitize num-string) 6 10))

(defn starts-with-0-or-1? [num-string]
  (re-find #"^(0|1)" num-string))

(defn number [num-string]
  (let [string (sanitize num-string)]
    (if (or 
          (starts-with-0-or-1? string)
          (starts-with-0-or-1? (exchange-code string))
          (> (count string) 10))
      "0000000000"
      string)))

(defn pretty-print [num-string]
  (format "(%s) %s-%s" 
          (area-code num-string)
          (exchange-code num-string)
          (subscriber-number num-string)))
