(ns armstrong-numbers)

(defn digits
  "Accept integer and parse into individual digits"
  [num]
  (map #(- (int %) 48) (str num)))

(defn raised
  "Multiply base by itself exp number of times"
  [base exp]
  (reduce * (repeat exp base)))

(defn products
  [num]
  (let [pow (count (str num))]
    (map #(raised % pow) (digits num))))

(defn armstrong?
  "An Armstrong number is a number that is the sum of its own digits each
  raised to the power of the number of digits. Return boolean to indicate
  whether argument passed is a valid Armstrong number."
  [num]
  (= num (apply + (products num))))
