(ns complex-numbers)

(defn real [[a b]] a)

(defn imaginary [[a b]] b)

(defn abs [[a b]] (Math/sqrt (+ (Math/pow a 2) (Math/pow b 2))))

(defn conjugate [[a b]] [a (* b -1)])

(defn add [[a b] [c d]] [(+ a c) (+ b d)])

(defn sub [[a b] [c d]] [(- a c) (- b d)])

(defn mul [[a b] [c d]] [(- (* a c) (* b d)) (+ (* b c) (* a d))])

(defn div [[a b] [c d]]
  (let [c2 (Math/pow c 2)
        d2 (Math/pow d 2)
        real-part (/ (+ (* a c) (* b d)) (+ c2 d2))
        imaginary-part (/ (- (* b c) (* a d)) (+ c2 d2))]
      [real-part imaginary-part]))
