(ns pov
  (:require [clojure.zip :as z]))
; (def simple-tree [:parent [:sibling] [:x]])
; (def simple-pulled [:x [:parent [:sibling]]])
; (def dz (z/vector-zip simple-pulled))

(defn of [target input]
  (prn "target" target)
  (prn "input" input)
  (def tree (z/vector-zip input))

  (loop [curr (z/down tree)]
    (prn "curr" curr)
    (let [node (z/node curr)]
      (prn "node" node)
      (if (= node target)
        (do
          (prn "found" node)
          (prn "root curr" (z/root curr))
          (prn "path curr" (z/path curr))
          (prn "up curr" (z/up curr))
          (vector target (z/root (z/remove (z/up curr))))
          ; (z/root curr)
          ; (prn "up node" (z/up node))
          ; node
          )
        (do
          (if (z/end? node)
            (do
              (prn "end")
              node
              )
            (do
              (prn "not nil")
; http://www.exampler.com/blog/2010/09/01/editing-trees-in-clojure-with-clojurezip/
; TODO provide :else loc ???
              (recur (-> curr z/next z/down)) ;; descend "left"
              )
            ; (recur (-> curr z/right z/down))) ;; descend "right"
          ))
      ))))

(defn __of [target input]
  (prn "of target " target)
  (prn "of input " input)

  (def zipper (z/vector-zip input))

  (-> zipper z/next z/next z/next z/next z/next z/root))
  ; (println (-> zipper z/next z/next z/next z/next z/next z/node)))
  ; (println (-> zipper z/down z/next z/up z/next z/next z/next z/next z/node)))

(defn _of [target input]
  (prn "of target " target)
  (prn "of input " input)

  (loop [loc (z/vector-zip input)]

    (prn "loc " loc)
    (prn "root " (z/root loc))
    (prn "node " (z/node loc))
    (prn "path " (z/path loc))
    (prn "prev " (z/prev loc))
    (prn "next " (z/next loc))
    (prn "left " (z/left loc))
    (prn "right " (z/right loc))
    (prn "down " (z/down loc))
    (prn "up " (z/up loc))
    (prn "children " (z/children loc))
    (prn "----------------------------")

    (when (= loc target)
      (prn "found")
      (z/node loc))

    (when (z/branch? loc)
      (prn "branch")
      (loop [child (first (z/children loc))]
        (prn "child " child)

        (when (= child target)
          (prn "found*")
          (z/node loc))

        (when (z/end? child)
          (prn "end (go up)")
          (z/up child))

          ))

    (when (z/down loc)
      (prn "down")
      (z/down loc))

    (when (z/next loc)
      (prn "next")
      (z/next loc))
    ))

(defn path-from-to [from to]
  (prn "from" from)
  (prn "to" to))
