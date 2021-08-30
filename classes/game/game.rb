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
    @game_active = true
  end

  def start
    # ask player for the name
    player.name = clear_ask_for('Enter your name: ', :str)
    dealer.name = 'Dealer'
    player.credit = 100
    dealer.credit = 100

    loop do
      # clear screen
      system 'clear'
      # start game
      game
      # after end ask player for continue
      break unless ask('Do you want to continue the game?')
    end
  end

  private

  def game
    start_game
    make_bid(10)

    loop do
      show_table(dealer, player, bank, :invisible)
      player_turn
      break if break_game?

      dealer_turn
      break if break_game?
    end

    end_game
  end

  # make bid
  def make_bid(bid)
    @bank += player.bid(bid) + dealer.bid(bid)
  end

  # give random card from existing deck
  def random_card
    result = @deck.sample(1)
    @deck.delete result
    result.first
  end

  # check game status
  def break_game?
    three_cards = dealer.cards == 3 && player.cards == 3 ? true : false
    player_not_in_game = dealer.in_game? && player.in_game? ? false : true

    game_unactive? || three_cards || player_not_in_game
  end

  # player turn
  def player_turn
    case ask_for("Your turn:   1. Skip   2. Take card   3. Open cards\n")
    when 2
      player.take_card random_card
    when 3
      @game_active = false
    end
  end

  # dealer turn
  def dealer_turn
    dealer.take_card random_card if dealer.points < 17
  end

  # game is active now?
  def game_unactive?
    !@game_active
  end

  # start game
  def start_game
    @game_active = true

    @deck = new_deck

    dealer.prepare_for_new_game
    player.prepare_for_new_game

    2.times { player.take_card random_card }
    2.times { dealer.take_card random_card }
  end

  # end game
  def end_game
    show_table(dealer, player, bank)

    puts "#{result_game}\n\n"
  end

  # result message
  def result_game
    bank_to(winner)

    winner_info = winner ? "#{winner.name} win!" : "It's draw!"
    "#{player.name}'s points: #{player.points}, Dealer's points: #{dealer.points}.   #{winner_info}"
  end

  # winner
  def winner
    dealer_points = dealer.result
    player_points = player.result

    return nil if dealer_points == player_points

    dealer_points > player_points ? dealer : player
  end

  # distribution of bank
  def bank_to(winner)
    if winner
      winner.take_credits(@bank)
    else
      player.take_credits(bank / 2)
      dealer.take_credits(bank / 2)
    end

    @bank = 0
  end
end
