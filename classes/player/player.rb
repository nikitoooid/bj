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

  def take_credits(sum)
    @credit += sum
  end

  def bid(sum)
    @credit -= sum
    sum
  end

  def in_game?
    points <= 21
  end

  def result
    points <= 21 ? points : 0
  end

  def prepare_for_new_game
    @points = 0
    @cards = []
  end

  private

  def calculate_card(card)
    card_value = card[:value]
    if card_value == 'A'
      points > 10 ? 1 : 11
    elsif card_value.to_i.zero?
      10
    else
      card_value.to_i
    end
  end
end
