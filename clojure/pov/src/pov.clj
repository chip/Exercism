(ns pov
  (:require [clojure.zip :as z])
  (:require [clojure.pprint :as pp]))
; (def simple-tree [:parent [:sibling] [:x]])
; (def simple-pulled [:x [:parent [:sibling]]])
; (def dz (z/vector-zip simple-pulled))

(def target-with-children
  [:grand-parent
   [:parent
    [:x
     [:child-1]
     [:child-2]]
    [:sibling
     [:nephew]
     [:niece]]]
   [:aunt
    [:cousin-1
     [:2nd-cousin-1]
     [:2nd-cousin-2]]
    [:cousin-2
     [:2nd-cousin-3]
     [:2nd-cousin-4]]]])

(def with-kids-pulled
  [:x
   [:child-1]
   [:child-2]
   [:parent
    [:sibling
     [:nephew]
     [:niece]]
    [:grand-parent
     [:aunt
      [:cousin-1
       [:2nd-cousin-1]
       [:2nd-cousin-2]]
      [:cousin-2
       [:2nd-cousin-3]
       [:2nd-cousin-4]]]]]])

; expected: (= with-kids-pulled (pov/of :x target-with-children))

; find target
; remove/save parent node
; append node removed to parent
; ????
; -------- OR --------
; find target
; remove/save node
; append parent 
(defn of [target input]
  (prn "target-with-children")
  (pp/pprint target-with-children)
  (prn "with-kids-pulled")
  (pp/pprint with-kids-pulled)
  (def tree (z/vector-zip input))

  (loop [loc (z/down tree)]
    (when (z/branch? loc)
      (when-let [children (z/children loc)]
        (prn "children")
        (pp/pprint children)))
    (when-let [parent (z/up loc)]
      (prn "parent")
      (pp/pprint parent))
    (when-let [node (z/node loc)]
      (prn "node")
      (pp/pprint node)
      (if (= node target)
        (do
          (prn "= node target")
          (pp/pprint (z/remove loc))
          (if (= (vector target) (z/root loc))
            (do
              (prn "if (= (vector target) (z/root loc))")
              (vector target))
            (do
              (prn "root loc" (z/root loc)
              (prn "path loc" (z/path loc))
              (prn "z/remove loc")
              (pp/pprint (z/remove (z/remove loc))))
              (vector target (z/root (z/remove (z/remove loc)))))))
        (if (z/end? node)
          (do
            (prn "end")
            node)
          (do
            ; (prn "not nil")
            ; http://www.exampler.com/blog/2010/09/01/editing-trees-in-clojure-with-clojurezip/
            ; TODO provide :else loc ???
            (prn "recur")
            (recur (-> loc z/next z/down)) ;; descend "left"
            ; (recur (-> loc z/right z/down))) ;; descend "right"
            )
        )))))

; [:0
;   [:1
;     [:4 :5]]
;   [:2
;     [:6 :7]]
;   [:3
;     [:8 :9]]]
;
; [:6
;   [:2
;     [:7]
;     [:0
;       [:1
;         [:4 :5]]
;       [:3
;         [:8 :9]]]]]

(defn of__ [target input]
  (prn "of target " target)
  (prn "of input " input)

  (def zipper (z/vector-zip input))

  ; (-> zipper z/next z/next z/next z/next z/next z/root))
  (prn "results")
  (println (-> zipper z/next z/next z/next z/next z/up z/node)))
  ; (println (-> zipper z/down z/next z/up z/next z/next z/next z/next z/node)))

(defn __of [target input]
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
