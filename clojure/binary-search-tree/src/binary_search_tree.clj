(ns binary-search-tree
  (require [clojure.string :as str]))

(str/split-lines "1\n10001") ; read-string
(defrecord Node [el left right])

(defn value [n]
  (:el n))

(defn singleton [el]
  (prn "singleton" el)
  (Node. el nil nil))

(defn insert
  [el]
  (singleton el)
  [el node]
  (prn "node value" (value node))
  (singleton el)
  )

(defn left [] ;; <- arglist goes here
  ;; your code goes here
)

(defn right [] ;; <- arglist goes here
  ;; your code goes here
)

(defn to-list [] ;; <- arglist goes here
  ;; your code goes here
)

(defn from-list [] ;; <- arglist goes here
  ;; your code goes here
)
