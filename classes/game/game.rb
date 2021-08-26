# frozen_string_literal: true

class Game
  include TextInterface

  attr_reader :player, :dealer, :bank

  def initialize(settings = {})
    @player = settings[:player] ||= Player.new
    @dealer = settings[:dealer] ||= Player.new
    @bank = settings[:bank] ||= 100
  end

  def start
    # ask player for the name
    player.name = ask_for('Enter your name: ', :str, false)

    loop do
      # start game (return true if win and false if loose)
      begin_game
      # ask player for new game
      break unless ask('Do you want to repeat the game?')
    end
  end

  private

  def begin_game
    
  end
end
