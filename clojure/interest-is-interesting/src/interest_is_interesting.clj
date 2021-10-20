(ns interest-is-interesting
  (:require [clojure.math.numeric-tower :as math]))

(defn interest-rate
  "Calculate the interest rate based on the specified balance"
  [balance]
  (double (cond
            (< balance 0M) -3.213
            (< balance 1000M) 0.5
            (< balance 5000M) 1.621
            (>= balance 5000M) 2.475)))

(defn interest-multiplier [rate] (/ rate 100M))

(defn interest-earned
  "Calculate the interest earned based on the specified balance"
  [balance]
  (* (bigdec (interest-multiplier (interest-rate balance))) (math/abs balance)))

(defn annual-balance-update
  "Calculate the annual balance update, taking into account the interest rate"
  [balance]
  (with-precision 26 (+ (interest-earned balance) balance)))

(defn amount-to-donate
  "Calculate how much money to donate to charities based on the balance and the
  tax-free percentage that the government allows"
  [balance tax-free-percentage]
  (if (pos? balance)
    (int (* (* (interest-multiplier tax-free-percentage) balance) 2))
    0))
