(ns grade-school)

(defn grade [school grade]
  (let [students (get school grade)]
    (if students students [])))

(defn add [school name grade]
  (let [students (get school grade)]
    (if students
      (assoc school grade (conj students name))
      (assoc school grade (conj [] name)))))

(defn sorted [school]
  (into (sorted-map)
    (map (fn [[k v]] [k (vec (sort v))])) school))
