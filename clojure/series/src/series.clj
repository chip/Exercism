(ns series)

(defn slices [string length]
  (let [size (count string)]
    (if (or (empty? string) (> length size))
      []
      (if (zero? length)
        [""]
        (into []
          (loop [start 0 end length memo []]
            (if (< end size)
              (recur (inc start) (inc end) (conj memo (subs string start end)))
              (conj memo (subs string start size))
            )
          )
        )
      )
    )
  )
)
