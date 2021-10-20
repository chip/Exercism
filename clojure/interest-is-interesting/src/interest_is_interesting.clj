(ns interest-is-interesting
  (:require [clojure.math.numeric-tower :as math]))

(defn interest-rate
  "Calculate the interest rate based on the specified balance"
  [balance]
  (let [rate (cond
      (< balance 0M) -3.213
      (< balance 1000M) 0.5
      (< balance 5000M) 1.621
      (>= balance 5000M) 2.475)]
    (double rate)
    ))

(defn annual-balance-update
  "Calculate the annual balance update, taking into account the interest rate"
  [balance]
  (let [interest-rate-converted (bigdec (/ (interest-rate balance) 100M))
        interest-earned (bigdec (* interest-rate-converted (math/abs balance)))]
    (with-precision 26 (+ interest-earned balance))))

(defn amount-to-donate
  "Calculate how much money to donate to charities based on the balance and the
  tax-free percentage that the government allows"
  [balance tax-free-percentage]
  (if (pos? balance)
    (int (* (* (/ tax-free-percentage 100M) balance) 2))
    0))
