// Package blackjack provides functions for playing the first turn of the game
package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch card {
	case "ace":
		return 11
	case "two":
		return 2
	case "three":
		return 3
	case "four":
		return 4
	case "five":
		return 5
	case "six":
		return 6
	case "seven":
		return 7
	case "eight":
		return 8
	case "nine":
		return 9
	case "ten", "jack", "queen", "king":
		return 10
	default:
		return 0
	}
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	sum := ParseCard(card1) + ParseCard(card2)
	// Split when player has 2 aces
	if sum == 22 {
		return "P"
	}
	dealerSum := ParseCard(dealerCard)
	// Hold when player has score less than or equal to 11
	// Hold when player has score between 12 and 16 and dealer has score of at least 7
	if sum <= 11 || (sum >= 12 && sum <= 16 && dealerSum >= 7) {
		return "H"
	}
	// Automatically win when player has blackjack and dealer has score of less than 10
	if sum == 21 && dealerSum < 10 {
		return "W"
	}
	// Default tactic is to Stay
	return "S"
}
