(ns beer-song
  (:require [clojure.string :as str]))

(defn last-verse
  []
  "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n")

(defn bottles
  [num]
  (format "%s %s" (if (= num 0) "no more" num) (if (= num 1) "bottle" "bottles")))

(defn of-beer [] "of beer")

(defn on-the-wall [] "on the wall")
(defn of-beer-on-the-wall [] (format "%s %s" (of-beer) (on-the-wall)))

(defn verse-part-1
  [num]
  (let [bottles-str (bottles num)]
    (format "%s %s, %s %s" bottles-str (of-beer-on-the-wall) bottles-str (of-beer))))

(defn take-one-down
  [num]
  (format "%s %s %s" "Take" (if (= num 1) "it" "one") "down and pass it around,"))

(defn compose-verse
  [num]
  (format "%s.\n%s %s %s.\n" 
                  (verse-part-1 num)
                  (take-one-down num)
                  (bottles (dec num)) 
                  (of-beer-on-the-wall)))

(defn verse
  "Returns the nth verse of the song."
  [num]
  (if (= num 0)
    (last-verse)
    (compose-verse num)))

(defn sing
  ([start]
    (sing start 0))
  ([start end]
   (str/join "\n" (map #(beer-song/verse %) (range start (dec end) -1)))))
