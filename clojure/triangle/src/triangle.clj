(ns triangle)

(defn valid?
  "validate triangle sides based upon rules"
  [x y z]
  (and
    ;; sum of 2 sides is greater than or equal remaining side 
    (and
      (>= (+ x y) z)
      (>= (+ y z) x)
      (>= (+ x z) y))
    ;; all sides are positive numbers
    (every? pos? (list x y z))))

(defn equilateral?
  "does triangle follow equilateral definition?"
  [x y z]
  (and
    (valid? x y z)
    (and
      (= x y)
      (= y z)
      (= x z))))

(defn isosceles?
  "does triangle follow isosceles definition?"
  [x y z]
  (and
    (valid? x y z)
    (or (= x y)
        (= y z)
        (= z x))))

(defn scalene?
  "does triangle follow scalene definition?"
  [x y z]
  (and
    (valid? x y z)
    (= 3 (count (distinct [x y z])))))
