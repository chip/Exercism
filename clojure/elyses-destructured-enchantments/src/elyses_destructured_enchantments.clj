(ns elyses-destructured-enchantments)

(defn first-card
  "Returns the first card from deck."
  [deck]
  (let [[primary _] deck]
    primary))

(defn second-card
  "Returns the second card from deck."
  [deck]
  (let [[_ secondary _] deck]
    secondary))

(defn swap-top-two-cards
  "Returns the deck with first two items reversed."
  [deck]
  (let [[primary secondary _] deck]
    (assoc (assoc deck 0 secondary) 1 primary)))

(defn discard-top-card
  "Returns a vector containing the first card and
   a vector of the remaining cards in the deck."
  [deck]
  (let [[top & rest] deck]
    (vec [top rest])))

(defn insert-face-cards
  "Returns the deck with face cards between its head and tail."
  [deck]
  (let [[head & tail] deck]
    (flatten (into [] (filter #(some? %) [head ["jack" "queen" "king"] tail])))))
