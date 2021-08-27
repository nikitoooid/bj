# frozen_string_literal: true

class Player
  attr_accessor :credit, :cards, :name
  attr_reader :points

  def initialize
    @name = ''
    @credit = 0
    @points = 0
    @cards = []
  end

  def take_card(card)
    cards << card
    @points += calculate_card(card)
  end

  def bid(sum)
    @credit -= sum
    sum
  end

  private

  def calculate_card(card)
    card_value = card[:value]
    if card_value == 'A' # если туз
      points > 10 ? 1 : 11
    elsif card_value.to_i.zero?   # если не цифра и не туз
      10
    else                          # если цифра
      card_value.to_i
    end
  end
end
