(ns robot-name
  (:require [clojure.string :as str]))

(defn string-builder [n s] (apply str (repeatedly n #(rand-nth s))))
(defn generate-2-letters [] (string-builder 2 "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
(defn generate-3-numbers [] (string-builder 3 "0123456789"))
(defn generate-name [] (str/join "" [(generate-2-letters) (generate-3-numbers)]))
; (def state (atom {}))
; (def state (atom #{}))
(def state (atom (hash-set)))

(defn robot []
  (loop []
    (println "loop")
    (let [name (generate-name)]
      (println "name " name)
      (if (get @state name)
        (do
          (println "before recur" @state)
          (recur)
        )
        (do
          (println "before @state " @state)
          (swap! state merge @state {:robot name :reset 0})
          (println "after @state " @state)
          @state
          )))))
(robot-name/robot)

(defn robot-name [robot]
  (println "robot-name " robot)
  (println "@state " @state)
  (println (get @state robot))
  (if (get @state robot) robot nil)
)

(defn reset-name [robot]
  (println "reset-name " robot)
  (if (get @state robot)
    recur
    (do
      (swap! state :robot name :reset 1)
      (robot-name/robot)
      )))

(defn -main []
  (-> (robot-name/robot) robot-name/robot-name))
; (robot-name/reset-name "foo")
