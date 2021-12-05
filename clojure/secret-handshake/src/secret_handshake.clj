(ns secret-handshake)

(defn too-big? [n]
  (>= n 32))

(defn commands [n]
  (if (too-big? n)
    (vector)
    (let [sorted? (>= n 16)]
      (loop [x (if sorted? (- n 16) n) events []]
        (cond 
          (zero? x) (if sorted? events (reverse events))
          :else
            (cond
              (>= x 8) (recur (- x 8) (conj events "jump"))
              (>= x 4) (recur (- x 4) (conj events "close your eyes"))
              (>= x 2) (recur (- x 2) (conj events "double blink"))
              (>= x 1) (recur (- x 1) (conj events "wink"))))))))
