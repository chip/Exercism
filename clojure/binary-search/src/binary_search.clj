(ns binary-search)

(defn middle [coll]
  (int (Math/floor (/ (count coll) 2))))

(defn fff [v]
  (prn "v" v)
  (let [v-copy v]
    (prn "KEYS:" (keys v-copy))
    (recur (rest v))))

(defn search-for [n coll]
  (prn "search-for n" n)
  (prn "search-for coll" coll)
  (let [cells (vec (map-indexed vector coll))]
    (prn "cells" cells)
    (loop [n n c cells]
      (prn "n" n)
      (prn "c" c)
      (let [m (middle c) [i x] (get c m)]
        (prn "m" m)
        (prn "i" i)
        (prn "x" x)
        (cond
          (and (not= n x) (= 1 (count c))) (throw (Exception. "not found"))
          (> n x) (do (prn "> n x") (recur n (vec (nthrest c m))))
          (< n x) (do (prn "< n x") (recur n (vec (take (inc m) c))))
          :else (do (prn "else") i))))))
  
(comment

  (as-> [[0 1] [1 3] [2 5] [3 8] [4 13] [5 21] [6 34] [7 55] [8 89]] c
    (vec (take 4 c)))

  (as-> [[0 1] [1 3] [2 4] [3 6] [4 8] [5 9] [6 11]] c
       (let [mid (middle c)]
         (get c mid)
         (vec (nthrest c mid))))

  (map-indexed vector [77 88 99 111 222])
  (defn search-for [n coll]
    (let [m (middle coll) x (get coll m)]
      (prn "m" m)
      (prn "x" x)
      (->> (map vector (iterate inc 1))
        (cond nthrest))))

  (defn search-for [n coll]
    (prn "n" n)
    (prn "coll" coll)
    (let [m (middle coll) x (get coll m)]
      (prn "m" m)
      (prn "x" x
      ; (if (= n x)
      ;   m
        (cond
          (= n x) (do
                      (prn "= n x")
                      m)
          (> n x) (do
                    (prn "> n x")
                    (search-for n (vec (nthrest coll m))))
          (< n x) (do
                    (prn "< n x")
                    (let [newcoll (map fff coll)]
                      (prn "newcoll" newcoll)
                      (search-for n newcoll))))))))
