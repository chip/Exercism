(ns change)

(comment
  (apply list [10 5]))
  
(defn whatevs [amount coins]
  (when (or (neg? amount) 
            ;; TODO fix when amount is less than all remaining coins
            (not (some #(<= % amount) coins)))
    (throw (IllegalArgumentException. "cannot change")))

  (let [sorted-coins (reverse (sort coins))]
    (prn "sorted-coins" sorted-coins)
    (loop [current-amount amount accum [] remaining-coins sorted-coins]
      (prn "current-amount" current-amount)
      (prn "accum" accum)
      (prn "remaining-coins" remaining-coins)
      (if (or (zero? current-amount) (zero? (count remaining-coins)))
        (apply list (sort accum))
        (let [coin (apply max-key identity remaining-coins)]
          (prn "coin" coin)
          (let [d (quot current-amount coin) rc (remove #(>= % coin) (seq remaining-coins))]
            (prn "d" d)
            (prn "rc" rc)
            (if (zero? d)
              (recur current-amount accum rc)
              (let [current-change (vec (repeat d coin))
                    new-accum (into accum current-change)
                    p (* d coin)
                    remainder (- current-amount p)]
                (prn "current-change" current-change)
                (prn "product" p)
                (prn "remainder" remainder)
                (recur remainder new-accum rc)))))))))

(defn issue [amount coins]
  (prn "issue" amount coins)
  (if (zero? amount)
    (list)
    (whatevs amount coins)))
