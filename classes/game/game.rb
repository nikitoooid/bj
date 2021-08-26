class Game
  attr_reader :player, :dealer, :bank

  def initialize(settings)
    @player = settings[:player]
    @dealer = settings[:dealer]
    @bank = settings[:bank]
  end

  
end