(ns etl
  (:require [clojure.string :as str]))

(defn process [[index, strings]]
  (into {} (map #(assoc {} (str/lower-case %) index) strings)))

(defn transform [source]
  (into {} (map process source)))
