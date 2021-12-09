(ns triangle)

(defn valid-sides?
  "validate sum of any 2 sides of a triangle are greater than or equal the remainind side"
  [[s s2 s3]]
  (and (>= (+ s s2) s3) (>= (+ s s3) s2) (>= (+ s2 s3) s)))

(defn non-zero?
  "validate all sides are positive numbers"
  [[s s2 s3]]
  (every? pos? (list s s2 s3)))

(defn valid?
  "validate triangle sides based upon rules"
  [sides]
  (and (valid-sides? sides) (non-zero? sides)))

(defn equal-sides?
  "validate triangle sides are all equal length"
  [[s s2 s3]]
  (and (= s s2) (= s s3) (= s2 s3)))

(defn equilateral?
  "does triangle follow equilateral definition?"
  [& sides]
  (and (valid? sides) (equal-sides? sides)))

(defn at-least-2-sides-equal?
  "validate at least 2 sides of the triangle are of equal length"
  [[s s2 s3]]
  (or (= s s2) (= s s3) (= s2 s3)))

(defn isosceles?
  "does triangle follow isosceles definition?"
  [& sides]
  (and (valid? sides) (at-least-2-sides-equal? sides)))

(defn unique-sides?
  "are triangle sides all unique in length?"
  [sides]
  (= 3 (count (set sides))))

(defn scalene?
  "does triangle follow scalene definition?"
  [& sides]
  (and (valid? sides) (unique-sides? sides)))
