package gross

import "fmt"

// Units stores the Gross Store unit measurements.
func Units() map[string]int {
	return map[string]int{
		"quarter_of_a_dozen": 3,
		"half_of_a_dozen":    6,
		"dozen":              12,
		"small_gross":        120,
		"gross":              144,
		"great_gross":        1728,
	}
}

// NewBill creates a new bill.
func NewBill() map[string]int {
	return make(map[string]int)
}

// AddItem adds an item to customer bill.
func AddItem(bill, units map[string]int, item, unit string) bool {
	measurement := units[unit]
	if measurement <= 0 {
		return false
	}
	_, ok := bill[item]
	if !ok {
		bill[item] = 0
	}
	bill[item] += measurement
	return true
}

// RemoveItem removes an item from customer bill.
func RemoveItem(bill, units map[string]int, item, unit string) bool {
	fmt.Println("bill:", bill, "item:", item, "unit:", unit)
	qty, ok := bill[item]
	fmt.Println("qty:", qty, "ok", ok)
	if !ok {
		fmt.Println("!ok return false")
		return false
	}
	measurement, ok := units[unit]
	fmt.Println("measurement:", measurement, "ok:", ok)
	if !ok {
		// if !ok {
		// fmt.Println("!ok || measurement < 0 then return false:", !ok, measurement < 0)
		fmt.Println("!ok then return false:", !ok)
		return false
	}
	newQty := qty - measurement
	if newQty < 0 {
		return false
	}
	if newQty == 0 {
		fmt.Println("delete item then return true:", item)
		delete(bill, item)
		return true
	}
	bill[item] -= measurement
	fmt.Println("final bill[item] then return true:", bill[item])
	return true
}

// GetItem returns the quantity of an item that the customer has in his/her bill.
func GetItem(bill map[string]int, item string) (int, bool) {
	amount, ok := bill[item]
	if !ok {
		return 0, false
	}
	return amount, true
}
