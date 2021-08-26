# frozen_string_literal: true

class Game
  include TextInterface
  include Cards

  attr_reader :player, :dealer, :bank

  def initialize
    @player = Player.new
    @dealer = Player.new
    @bank = 0
    @deck = []
  end

  def start
    # ask player for the name
    player.name = ask_for('Enter your name: ', :str, false)

    loop do
      # start game
      begin_game
      # ask player for new game
      break unless ask('Do you want to repeat the game?')
    end
  end

  private

  def begin_game
    # создаем колоду карт
    @deck = new_deck

    # выдаем пользователю и дилеру по 2 карты (объекты класса player считают свои очки)
    2.times{player.take_card random_card}
    2.times{dealer.take_card random_card}

    # цикл игры
    
  end

  # give random card from existing deck
  def random_card
    result = @deck.sample(1)
    @deck.delete result
    result
  end
end
