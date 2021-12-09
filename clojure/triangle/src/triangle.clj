(ns triangle)

(defn is-valid? [s s2 s3]
  (and (>= (+ s s2) s3) (>= (+ s s3) s2) (>= (+ s2 s3) s)
       (every? pos? (list s s2 s3))))

(defn equilateral? [s s2 s3]
  (if (is-valid? s s2 s3)
    (and (= s s2) (= s s3) (= s2 s3))
    false
    ))

(defn isosceles? [s s2 s3]
  (if (is-valid? s s2 s3)
    (or (= s s2) (= s s3) (= s2 s3))
    false))

(defn scalene? [s s2 s3]
  (if (is-valid? s s2 s3)
    (= 3 (count (set (list s s2 s3))))
    false
    ))
