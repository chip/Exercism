(ns space-age)

(def earth-orbit-in-seconds (float 31557600.0))

(defn on-earth [n]
  (/ n earth-orbit-in-seconds))

;; All floats below represent orbital period in earth years for a given planet
(defn on-mercury [n]
  (/ (on-earth n) (float 0.2408467)))

(defn on-venus [n]
  (/ (on-earth n) (float 0.61519726)))

(defn on-mars [n]
  (/ (on-earth n) (float 1.8808158)))

(defn on-jupiter [n]
  (/ (on-earth n) (float 11.862615)))

(defn on-saturn [n]
  (/ (on-earth n) (float 29.447498)))

(defn on-uranus [n]
  (/ (on-earth n) (float 84.016846)))

(defn on-neptune [n]
  (/ (on-earth n) (float 164.79132)))
