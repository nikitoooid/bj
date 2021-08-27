# frozen_string_literal: true

module Cards
  SUITS = ['♠', '♦', '♣', '♥'].freeze
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', 'J', 'Q', 'K', 'A'].freeze

  # generate new deck
  def new_deck
    result = []

    SUITS.each do |s|
      VALUES.each do |v|
        result << { value: v, suit: s }
      end
    end

    result
  end
end
