(ns accumulate)

; (defn- to-s [xs] (apply str xs))

(defn accumulate
  [f & args]
  (prn "f " f)
  (prn "args " args)
  (prn "type args " (type args))
  (let [v (first args)]
    (prn "v " v)
    (prn "type v: " (type v))
    (if (empty? v)
      (do 
        (prn "do ")
        v
        )
      (do
        (prn "else do ")
        (loop [coll v accum []]
          (prn "coll: " coll)
          (prn "count " (count coll))
          (prn "accum: " accum)

          (if (= zero? (rest coll))
            accum
            (do
              (prn "else ")
              (let [r (rest coll) item (first coll)]
                (prn "rest " r)
                (prn "item " item)
                (if (nil? item)
                  accum
                  (do
                    (let [result (f item)]
                      (prn "result " result)
                      (recur r (conj accum result))
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
)
