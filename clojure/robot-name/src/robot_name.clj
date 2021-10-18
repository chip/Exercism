(ns robot-name
  (:require [clojure.string :as str]))

(def memory (atom {}))
(def robots (atom #{}))

(defn mem []
  (prn "mem() after @robots: " @robots)
  (prn "mem() after @memory " @memory))

(defn random-letters []
  (str/join "" (take 2 (repeatedly #(char (+ (rand 26) 65))))))

(defn random-numbers []
  (str/join "" (take 3 (repeatedly #(rand-int 10)))))

(defn random-name []
  (let [its-name (str (random-letters) (random-numbers))]
    (if (contains? @robots its-name) (recur) its-name)))

(defn random-key []
  (keyword (gensym "robot-")))

; Find robot name by looking up memory using key
(defn get-name [robot-key]
  (if-let [robot-name (get @memory robot-key)]
    robot-name
    nil))
  
(defn update-memory [robot-key robot-name]
  (prn "update-memory robot-key " robot-key)
  (prn "update-memory robot-name: " robot-name)
  (swap! robots conj robot-name)
  (swap! memory conj (hash-map robot-key robot-name)))

(defn robot-exists? [robot-key]
  (contains? @robots (get-name robot-key)))

;; Generate random robot name (2 alphabetic characters followed by 3 digits
;; Check name for collisions (using a global state: atom with a set to ensure uniqueness)
;; Add to set
;; Return robot instance (is a string sufficient?)
(defn robot []
  (mem)
  (let [robot-key (random-key)
        robot-name (random-name)]
    (prn "robot-key: " robot-key)
    (prn "robot-name " robot-name)
    (update-memory robot-key robot-name)
    (mem)
    robot-key
    ))

;; Lookup robot (or name) in set
;; Return it if it exists
(defn robot-name [robot-key]
  (get-name robot-key))

;; Lookup robot (or name) in set
;; Remove from set
;; Call (robot)
(defn reset-name [robot-key]
  (prn "reset-name() robot-key " robot-key)
  (mem)
  (let [robot-name (random-name)]
    (if (robot-exists? robot-key)
      (do
        (update-memory robot-key robot-name)
        robot-key
      )
      nil
    )))

(defn reset-memory []
  (reset! robots #{})
  (reset! memory {}))

(get-name :robot-5517)
(reset-name :robot-5517)
(mem)
(robot)
(robot-name :robot-5550)
(reset-memory)
; (let [a-robot (robot-name/robot)
;       its-original-name (robot-name/robot-name a-robot)
;       its-new-name (do (robot-name/reset-name a-robot)
;                        (robot-name/robot-name a-robot))]
; (is (not= its-new-name (do (robot-name/reset-name a-robot)
;                            (robot-name/robot-name a-robot))))))
