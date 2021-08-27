# frozen_string_literal: true

class Game
  include TextInterface
  include GraphicalInterface
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
    player.name = clear_ask_for('Enter your name: ', :str, false)
    player.credit = 100
    dealer.credit = 100

    loop do
      # start game
      begin_game

      # after end ask player for new game
      break unless ask('Do you want to repeat the game?')
    end
  end

  private

  def begin_game
    # создаем колоду карт
    @deck = new_deck

    # выдаем пользователю и дилеру по 2 карты (объекты класса player считают свои очки)
    2.times { player.take_card random_card }
    2.times { dealer.take_card random_card }

    # ставка
    @bank += player.bid(10) + dealer.bid(10)

    # цикл игры
    loop do
      show(dealer, player, bank, false)
      case ask_for('Your turn:   1. Skip   2. Take card   3. Open cards')
      when 2
        player.take_card random_card
      when 3
        show(dealer, player, bank, true)
        break
      end
      dealer.take_card random_card
    end
  end

  # give random card from existing deck
  def random_card
    result = @deck.sample(1)
    @deck.delete result
    result.first
  end
end
