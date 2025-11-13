module Blackjack
  CARD_VALUES = %w[other one two three four five six seven eight nine]

  def self.parse_card(card)
    case card
    when 'ace' then 11
    when 'ten', 'jack', 'queen', 'king' then 10
    else
      CARD_VALUES.include?(card) ? CARD_VALUES.index(card) : 0
    end
  end

  def self.card_range(card1, card2)
    case parse_card(card1) + parse_card(card2)
    when 21 then 'blackjack'
    when 17..20 then 'high'
    when 12..16 then 'mid'
    else 'low'
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    return 'P' if card1 == 'ace' && card2 == 'ace'

    case card_range(card1, card2)
    when 'blackjack' then win_or_stand?(dealer_card)
    when 'high' then 'S'
    when 'mid' then hit_or_stand?(dealer_card)
    else
      'H'
    end
  end

  def self.win_or_stand?(dealer_card)
    parse_card(dealer_card) < 10 ? 'W' : 'S'
  end

  def self.hit_or_stand?(dealer_card)
    parse_card(dealer_card) >= 7 ? 'H' : 'S'
  end
end
